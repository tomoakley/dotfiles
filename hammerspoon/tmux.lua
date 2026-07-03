local cmdPressed = false
local tmux = "/opt/homebrew/bin/tmux"

local function showStatus()
  hs.task.new(tmux, nil, { "display-message", "-d", "3000", "#{E:status-format[0]}" }):start()
end

local function hideStatus()
  -- Clear the message by showing an empty one with minimal duration
  hs.task.new(tmux, nil, { "display-message", "-d", "1", "" }):start()
end

-- map letters to my numpad for easy tmux window switching
local letterToNumPad = {
  ['y'] = '1',
  ['u'] = '2',
  ['i'] = '3',
  ['h'] = '4',
  ['j'] = '5',
}

-- Watcher for regular key presses (only active when Cmd is held)
alacrittyTmuxKeyWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
  local keyCode = event:getKeyCode()
  -- keyCode 33 is '[', keyCode 30 is ']'
  local targetNumber = letterToNumPad[hs.keycodes.map[keyCode]]
  if targetNumber then
    hs.eventtap.keyStroke({'ctrl'}, 'b')
    hs.eventtap.keyStroke({}, targetNumber)
    showStatus() -- keep status bar showing as tmux window is switched
    return true
  end
  showStatus()
  return false
end)

-- Watcher for cmd key beind held
alacrittyFlagWatcher = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
  local isCmdDown = event:getFlags().cmd == true
  local focusedApp = hs.application.frontmostApplication():name()

  if focusedApp ~= "Alacritty" then
    alacrittyTmuxKeyWatcher:stop()
    return
  end

  if isCmdDown and not cmdPressed then
    cmdPressed = true
    showStatus()
    alacrittyTmuxKeyWatcher:start()
  elseif not isCmdDown and cmdPressed then
    cmdPressed = false
    hideStatus()
    alacrittyTmuxKeyWatcher:stop()
  end
end)

alacrittyFlagWatcher:start()



