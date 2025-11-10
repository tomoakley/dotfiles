-- Define hotkeys only when Chrome is focused
local chromeAppName = "Google Chrome"

local function getIsTextFieldFocused()
  local win = hs.window.focusedWindow()
  if not win then return false end

  local elem = hs.uielement.focusedElement()
  if not elem then return false end

  local role = elem:role()
  --print('DEBUG: focused element role: ' .. role)
  return role == "AXTextField" or role == "AXTextArea" or role == "AXComboBox" or role == "AXGroup"
end


-- Create an eventtap for keyDown events
chromeKeyHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local app = hs.application.frontmostApplication()
  --print ('DEBUG: focused app name: ' .. app:name())
  if not app or app:name() ~= chromeAppName then
    return false -- Don't block the event
  end


  local isTextFieldFocused = getIsTextFieldFocused()
  local keyCode = event:getKeyCode()

  if isTextFieldFocused and keyCode == hs.keycodes.map.escape then
    hs.eventtap.keyStroke({}, "tab")
    -- may need some recursive function to check if the new element that's focussed is a text field
  end

  if isTextFieldFocused then
    return false
  end

  local flags = event:getFlags()

  -- Key codes: h = 4, l = 37
  if flags:containExactly({"shift"}) then
    if keyCode == hs.keycodes.map.h then
      hs.eventtap.keyStroke({"cmd"}, "[")
      return true -- Block original 'h'
    elseif keyCode == hs.keycodes.map.l then
      hs.eventtap.keyStroke({"cmd"}, "]")
      return true -- Block original 'l'
    elseif keyCode == hs.keycodes.map.j then
      hs.eventtap.keyStroke({"ctrl"}, "tab")
      return true
    elseif keyCode == hs.keycodes.map.k then
      hs.eventtap.keyStroke({"shift", "ctrl"}, "tab")
      return true
    elseif keyCode == hs.keycodes.map.o then
      hs.eventtap.keyStroke({"cmd"}, "t")
      hs.eventtap.keyStroke({"cmd"}, "l")
      return true
    elseif keyCode == hs.keycodes.map.g then
      hs.eventtap.keyStroke({"cmd"}, "down")
    end
  end

  if flags:containExactly({}) then
      if keyCode == hs.keycodes.map.j then
        hs.eventtap.scrollWheel({0, -10}, {}, "line") -- scroll down
        return true
      elseif keyCode == hs.keycodes.map.k then
        hs.eventtap.scrollWheel({0, 10}, {}, "line") -- scroll up
        return true
      elseif keyCode == hs.keycodes.map.o then
        hs.eventtap.keyStroke({"cmd"}, "l")
        return true
      elseif keyCode == hs.keycodes.map.d then
        hs.eventtap.keyStroke({"cmd"}, "w")
        return true
      elseif keyCode == hs.keycodes.map.f then
        hs.eventtap.keyStroke({"alt", "fn"}, "F9")
        return true
      elseif keyCode == hs.keycodes.map['/'] then
        hs.eventtap.keyStroke({"cmd"}, "f")
        return true
      elseif keyCode == hs.keycodes.map.g then
        -- ideally this would be `gg` to match vim but double taps in HS are tricky to detect
        hs.eventtap.keyStroke({"cmd"}, "up")
      end
  end

  return false -- Let other keys through
end)

chromeKeyHandler:start()
