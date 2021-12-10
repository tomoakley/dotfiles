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
  replacedApp = hs.application.frontmostApplication():name()
  openApp("Alacritty.app")
end)

hs.hotkey.bind({"ctrl"}, "2", function()
  replacedApp = hs.application.frontmostApplication():name()
  openApp("Qutebrowser.app")
end)

hs.hotkey.bind({"ctrl"}, "4", function()
  replacedApp = hs.application.frontmostApplication():name()
  openApp("Simulator.app")
  hs.eventtap.keyStroke({"fn"}, "F9")
end)

hs.hotkey.bind({"ctrl"}, "5", function()
  local currentApp = hs.application.frontmostApplication():name()
  openApp(replacedApp)
  replacedApp = currentApp
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

