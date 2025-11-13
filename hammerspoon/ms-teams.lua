local teamsAppName = "Microsoft Teams"

local function getFocusedElementRole()
  local win = hs.window.focusedWindow()
  if not win then return false end

  local elem = hs.uielement.focusedElement()

  if not elem then return false end

  local role = elem:role()
  -- print('DEBUG: focused element role: ' .. role)
  return role
end

teamsKeyHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local app = hs.application.frontmostApplication()
  --print ('DEBUG: focused app name: ' .. app:name())
  if not app or app:name() ~= teamsAppName then
    return false -- Don't block the event
  end

  local app = hs.application.get("Microsoft Teams")
  local axApp = hs.axuielement.applicationElement(app)
  axApp:setAttributeValue('AXEnhancedUserInterface', true)

  local elementRole = getFocusedElementRole()

  if elementRole == "AXTextField" or elementRole == "AXTextArea" or elementRole == "AXComboBox" --[[ or elementRole == "AXGroup" ]] then
    return false
  end

  local keyCode = event:getKeyCode()
  local flags = event:getFlags()

  if flags:containExactly({"shift"}) then
    if elementRole == 'AXMenuItem' then
      return false
    end
    if keyCode == hs.keycodes.map.j then
        hs.eventtap.keyStroke({"cmd"}, "l")
        hs.eventtap.keyStroke({}, "Down")
      return true
    end
    if keyCode == hs.keycodes.map.k then
        hs.eventtap.keyStroke({"cmd"}, "l")
        hs.eventtap.keyStroke({}, "Up")
    end
  end

  if flags:containExactly({}) then
    if elementRole == 'AXMenuItem' then
      if keyCode == hs.keycodes.map.escape then
        hs.eventtap.keyStroke({}, "escape")
        hs.eventtap.keyStroke({}, "return")
      end
      return false
    end
    if keyCode == hs.keycodes.map.u then
        hs.eventtap.keyStroke({"alt", "cmd"}, "u")
    end
    if keyCode == hs.keycodes.map.g then
        hs.eventtap.keyStroke({"cmd"}, "g")
    end
    if keyCode == hs.keycodes.map.j then
        hs.eventtap.keyStroke({"cmd"}, "p")
        hs.eventtap.scrollWheel({0, -10}, {}, "line") -- scroll down
    end
    if keyCode == hs.keycodes.map.k then
        hs.eventtap.keyStroke({"cmd"}, "p")
        hs.eventtap.scrollWheel({0, 10}, {}, "line") -- scroll up
    end
    if keyCode == hs.keycodes.map.i then
        hs.eventtap.keyStroke({"cmd"}, "R")
    end
    if keyCode == hs.keycodes.map.f then
      hs.eventtap.keyStroke({"alt", "fn"}, "F9")
    end
  end
  return false -- Let other keys through
end)

teamsKeyHandler:start()
