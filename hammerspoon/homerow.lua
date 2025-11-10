local homerowAppNames = {
  'Simulator',
--[[   'Slack', ]]
--[[   'Microsoft Teams' ]]
}

local homerowHotkeys = {}

-- Helper function to check if app is in the list
local function isHomerowApp(appName)
  for _, name in ipairs(homerowAppNames) do
    if appName == name then
      return true
    end
  end
  return false
end

local function getIsTextFieldFocused()
  local focusedElement = hs.uielement.focusedElement()

  if not focusedElement then
    return false
  end

  local role = focusedElement:role()

  -- Common text input roles
  local textRoles = {
    "AXTextField",
    "AXTextArea",
    "AXComboBox",
    "AXSearchField",
    "AXGroup"
  }

  for _, textRole in ipairs(textRoles) do
    if role == textRole then
      return true
    end
  end

  return false
end

-- Function to create a hotkey that checks for text fields
local function createSmartHotkey(mods, key, fn)
  return hs.hotkey.new(mods, key, function()
    if not isTextFieldFocused() then
      fn()
    else
      -- Text field is focused, let the key pass through
      -- You could optionally show an alert here for debugging
      -- hs.alert.show("Text field focused, ignoring hotkey")
    end
  end)
end

-- Function to enable your custom hotkeys
local function enableHomerowKeys()
  -- Example hotkeys - replace with your actual keybindings
  homerowHotkeys[1] = hs.hotkey.bind({}, "f", function()
    hs.eventtap.keyStroke({"alt", "fn"}, "F9")
  end)
end

-- Function to disable your custom hotkeys
local function disableHomerowKeys()
  for _, hotkey in ipairs(homerowHotkeys) do
    if hotkey then
      hotkey:delete()
    end
  end
  homerowHotkeys = {}
end

-- Create application watcher
keyHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local app = hs.application.frontmostApplication()
  print('DEBUG: '..app:name())
  if not isHomerowApp(app:name()) then
    disableHomerowKeys()
    return false
  end
--[[   hs.alert.show("Homerow keys enabled for: " .. app:name()) ]]
  local isTextFieldFocused = getIsTextFieldFocused()
  local keyCode = event:getKeyCode()

  if isTextFieldFocused then
    print('DEBUG: text field focussed')
    return false
  end

  local flags = event:getFlags()

  if flags:containExactly({}) then
    if keyCode == hs.keycodes.map.f then
      hs.eventtap.keyStroke({"alt", "fn"}, "F9")
      print(hs.uielement.focusedElement():role())
      return true
    end
  end
end)

-- Start watching
keyHandler:start()
