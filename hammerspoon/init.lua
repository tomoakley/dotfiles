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

local function convertSlackUrl(url)
  return url:gsub("^https://app.slack.com/client/(%w+)/(%w+)?open=start_huddle$", "slack://join-huddle\\?team=%1\\&id=%2")
end

hs.urlevent.httpCallback = function(_, _, _, url, _)
  local isSlackHuddleUrl = url:match("^https://app.slack.com/client/.+?/?open=start_huddle$")
  if isSlackHuddleUrl then
    local converted = convertSlackUrl(url)
    local command = "open -a safari " .. converted
    hs.execute(command)
  end
end

hs.urlevent.httpCallback = function(_, _, _, url, _)
  local pattern = "^https?://?github%.com/[%w%._%-]+/[%w%._%-]+/pulls?/?(%d*)$"
  local match = string.match(url, pattern)
  if match ~= nil then
    local task = hs.task.new(
      "/Users/tomoakley/.qutebrowser/octo-nvim.sh",
      function ()
      end,
      {url}
    )
    task:start()
  else
    local task = hs.task.new("/opt/homebrew/bin/qutebrowser", nil, {"--target", "tab", url})
    task:start()
  end
end

--[[ hs.hotkey.bind({"ctrl"}, "3", function()
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
end) ]]

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

