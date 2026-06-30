local cmdPressed = false
local tmux = "/opt/homebrew/bin/tmux"

local function setStatus(on)
  hs.task.new(tmux, nil, { "set-option", "status", on and "on" or "off" }):start()
end

watcher = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
  local isCmdDown = event:getFlags().cmd == true

  if isCmdDown and not cmdPressed then
    cmdPressed = true
    setStatus(true)
  elseif not isCmdDown and cmdPressed then
    cmdPressed = false
    setStatus(false)
  end
end)

watcher:start()
