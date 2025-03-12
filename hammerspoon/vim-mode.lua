local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

hs.chooser.globalCallback = function(chooser, eventName)
  hs.chooser._defaultGlobalCallback(chooser, eventName)

  if eventName == "willOpen" then
    vim:disable()
  else
    vim:enable()
  end
end

-- Configure apps you do *not* want Vim mode enabled in
-- For example, you don't want this plugin overriding your control of Terminal
-- vim
vim
  :disableForApp('Code')
  :disableForApp('zoom.us')
  :disableForApp('iTerm')
  :disableForApp('iTerm2')
  :disableForApp('Terminal')
  :disableForApp('Alacritty')

-- If you want the screen to dim (a la Flux) when you enter normal mode
-- flip this to true.
vim:shouldDimScreenInNormalMode(false)

-- If you want to show an on-screen alert when you enter normal mode, set
-- this to true
vim:shouldShowAlertInNormalMode(true)

-- You can configure your on-screen alert font
vim:setAlertFont("Courier New")

-- Enter normal mode by typing a key sequence
vim:enterWithSequence('jj', 200)

-- if you want to bind a single key to entering vim, remove the
-- :enterWithSequence('jk') line above and uncomment the bindHotKeys line
-- below:
--
-- To customize the hot key you want, see the mods and key parameters at:
--   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
--vim:bindHotKeys({ enter = { {'ctrl'}, ';' } })
