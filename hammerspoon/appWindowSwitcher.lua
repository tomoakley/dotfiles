hs.loadSpoon("RecursiveBinder")

spoon.RecursiveBinder.escapeKey = {{}, 'escape'}  -- abort with Escape

local singleKey = spoon.RecursiveBinder.singleKey

local function moveMouseAndFocusWindow()
  local screen = hs.mouse.getCurrentScreen()
  local nextScreen = screen:next()
  local center = nextScreen:frame().center
  hs.mouse.absolutePosition(center)
  hs.eventtap.leftClick(center)
end

local spaceMap = {}

local function updateSpaceMap()
  local win = hs.window.focusedWindow()
  if not win then return end

  local app = win:application()
  if not app then return end

  local appName = app:name()
  local winID = win:id()
  local screen = win:screen()
  local allSpaces = hs.spaces.spacesForScreen(screen)

  for index, spaceID in ipairs(allSpaces) do
    local windowsInSpace = hs.spaces.windowsForSpace(spaceID)
    if windowsInSpace then
      for _, id in ipairs(windowsInSpace) do
        if id == winID then
          spaceMap[appName] = { index = index, spaceID = spaceID }
          return
        end
      end
    end
  end
end

local function moveToSpace(appName)
    local data = spaceMap[appName]
    if data ~= nil then
      hs.eventtap.keyStroke({"cmd", "alt", "ctrl"}, tostring(data.index))
    else
      hs.application.launchOrFocus(appName)
    end
end

-- update the map whenever the focused app changes
appWatcher = hs.application.watcher.new(function(name, event, app)
  if event == hs.application.watcher.activated then
    updateSpaceMap()
    print('update')
    print(hs.inspect(spaceMap))  -- remove this once you're happy it works
  end
end)

appWatcher:start()


local keyMap = {
  [singleKey('h', 'mouse left')] = function()
    moveMouseAndFocusWindow()
  end,
  [singleKey('b', 'browser')] = function()
    moveToSpace("Google Chrome")
  end,
  [singleKey('t', 'terminal')] = function()
    moveToSpace("Alacritty")
  end,
  [singleKey('s', 'teams')] = function()
    moveToSpace("Microsoft Teams")
  end,
  [singleKey('l', 'mouse right')] = function()
    moveMouseAndFocusWindow()
  end,
}

-- Trigger with Option+Space (your "leader key")
hs.hotkey.bind({'ctrl'}, ',', spoon.RecursiveBinder.recursiveBind(keyMap))
