local serial = require("hs.serial")

-- Log available serial ports
--[[ print("Available serial ports:")
for _, path in ipairs(hs.serial.availablePortPaths()) do
    print("  " .. path)
end ]]

-- Mouse-edge switch state
local edgeSince = nil   -- time the mouse first touched the edge, or nil if not at edge
local fired = false     -- whether we've already sent SWITCH for this press
local HOLD_THRESHOLD = 0.3 -- seconds the mouse must stay pinned at the edge

local pico = nil              -- confirmed hs.serial object for the Pico
local lastKnownPath = nil     -- path that worked last time, tried first before rescanning
local pendingCandidates = {}  -- path -> hs.serial object, awaiting PONG
print(hs.inspect(hs.serial.availablePortPaths()))

-- hs.reload() tears down this whole Lua environment without closing our serial
-- ports first, which leaves the OS thinking the port is still in use and makes
-- the next load's open() fail until the device is physically unplugged. Close
-- everything before the actual reload happens.
local originalReload = hs.reload
hs.reload = function(...)
  print("reload")
    if pico then
        pico:close()
    end
    for _, candidate in pairs(pendingCandidates) do
        candidate:close()
    end
    return originalReload(...)
end

local function onPicoData(port, callbackType, message)
    print('message: ' .. tostring(message))
    if callbackType == "received" then
        if message then
            io.write(message)
            if message:match("SWITCHED") then
                print("resetting")
            end
        end
    else
        print("[pico serial] " .. callbackType)
        print(message)
        if callbackType == "removed" then
            pico = nil
            edgeSince = nil
            fired = false
                local screen = hs.screen.mainScreen()
                local frame = screen:frame()
                local pos = hs.mouse.absolutePosition()
                hs.mouse.absolutePosition({ x = frame.x + 20, y = pos.y })
        end
    end
end

-- Try a candidate cu.usbmodem* port: send PING, only keep it if PONG comes back.
-- onFail is called if this candidate doesn't answer in time.
local function tryIdentify(path, onFail)
    if pico or pendingCandidates[path] then return end

    local candidate = hs.serial.newFromPath(path)
    if not candidate then
        if onFail then onFail() end
        return
    end
    candidate:baudRate(9600)
    pendingCandidates[path] = candidate

    candidate:callback(function(port, callbackType, message)
        if callbackType == "received" then
            if message and message:match("PONG") then
                print("Confirmed Pico on " .. path)
                pendingCandidates[path] = nil
                pico = candidate
                lastKnownPath = path
                pico:callback(onPicoData)
            end
        else
            --print("[identify " .. path .. "] " .. callbackType)
            --print(message)
        end
    end)
    candidate:open()
    candidate:sendData("PING\n")

    -- Give up on this candidate if it never answers
    hs.timer.doAfter(1, function()
        if pendingCandidates[path] then
            pendingCandidates[path] = nil
            candidate:close()
            if onFail then onFail() end
        end
    end)
end

local function scanForPico()
    if pico then return end
    for _, path in ipairs(hs.serial.availablePortPaths()) do
        if path:match("cu%.usbmodem") then
            tryIdentify(path)
        end
    end
end

-- Try the previously confirmed path first; only rescan everything if that fails
local function findPico()
    if pico then return end
    if lastKnownPath then
        tryIdentify(lastKnownPath, scanForPico)
    else
        scanForPico()
    end
end

local usbWatcher = hs.usb.watcher.new(function(data)
    if data.eventType == "added" then
        -- give macOS a moment to create the /dev/cu.usbmodem* device node
        hs.timer.doAfter(0.5, findPico)
    end
end)
usbWatcher:start()

findPico() -- in case the Pico is already plugged in

-- Retry in case the first attempt hit a port still settling from a reload,
-- but give up after RETRY_TIMEOUT so it's not polling forever if nothing's plugged in
local RETRY_INTERVAL = 2  -- seconds between attempts
local RETRY_TIMEOUT = 30  -- seconds to keep retrying before giving up
local retryStarted = hs.timer.secondsSinceEpoch()
local retryTimer
retryTimer = hs.timer.doEvery(RETRY_INTERVAL, function()
    if pico then
        retryTimer:stop()
        return
    end
    findPico()
    if not pico and hs.timer.secondsSinceEpoch() - retryStarted >= RETRY_TIMEOUT then
        print("Gave up looking for the Pico after " .. RETRY_TIMEOUT .. "s; still watching for USB connects")
        retryTimer:stop()
    end
end)

-- Monitor mouse position
-- Must stay referenced (local at file scope) or Lua's GC will collect it and the timer stops firing.
mouseWatcherTimer = hs.timer.doEvery(0.1, function()
    if not pico then return end

    local pos = hs.mouse.absolutePosition()
    local screen = hs.screen.mainScreen()
    local frame = screen:frame()

    local isAtEdge = pos.x <= frame.x + 5

    if isAtEdge then
        if not edgeSince then
            edgeSince = hs.timer.secondsSinceEpoch()
        elseif not fired and hs.timer.secondsSinceEpoch() - edgeSince >= HOLD_THRESHOLD then
            print("switching")
            pico:sendData("SWITCH\n")
            fired = true
        end
    else
        edgeSince = nil
        fired = false
    end
end)

mouseWatcherTimer:start()
