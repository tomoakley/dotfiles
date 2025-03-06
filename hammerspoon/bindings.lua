local replacedApp = nil
function openApp(name)
  local app = hs.application.get(name)
  if app then
    if app:isFrontmost() then
      app:hide()
    else
      app:mainWindow():focus()
    end
  else
    hs.application.launchOrFocus(name)
  end
end

hs.hotkey.bind({"ctrl"}, "3", function()
  if replacedApp ~= nil and replacedApp ~= "Alacritty" then
    openApp(replacedApp..".app")
  end
  replacedApp = hs.application.frontmostApplication():name()
  openApp("Alacritty.app")
end)

hs.hotkey.bind({"ctrl"}, "4", function()
  if replacedApp ~= nil and replacedApp ~= "Qutebrowser" then
    openApp(replacedApp..".app")
  end
    replacedApp = hs.application.frontmostApplication():name()
  openApp("Qutebrowser.app")
end)

--[[ hs.hotkey.bind({"ctrl"}, "4", function()
  replacedApp = hs.application.frontmostApplication():name()
  openApp("Simulator.app")
  hs.eventtap.keyStroke({"fn"}, "F9")
end) ]]
