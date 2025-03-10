local menuBarItem = hs.menubar.new()

local webView = hs.webview.new({x = 0, y = 0, w = 800, h = 600})
    :windowStyle("resizable")
    :allowGestures(true)
    :allowTextEntry(true)
    :level(hs.drawing.windowLevels.modalPanel)
    :closeOnEscape(true)
    :url("https://www.kagi.com/assistant")

webView:shadow(true)

local webViewHotkeys = {}

local function enableWebViewHotkeys()
    if #webViewHotkeys == 0 then
        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "N", function()
            local jsCode = [[
              var button = document.querySelector('[title="New Thread"]');
              if (button) {
                  button.click();
              }
            ]]
            webView:evaluateJavaScript(jsCode)
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "H", function()
            local jsCode = [[
                var button = document.querySelector("#thread-sidebar-expand")
                if (button) {
                    button.click();
                }
            ]]
            webView:evaluateJavaScript(jsCode)
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "I", function()
          local frame = webView:frame()
          local point = hs.geometry.point((frame.x + frame.w/2), (frame.y + frame.h - 30))
          hs.eventtap.leftClick(point)
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd", "alt"}, "L", function()
          local screenFrame = hs.screen.mainScreen():frame()
          local webViewFrame = webView:frame()
          webView:frame({ w = 400, h = screenFrame.h })

          webViewFrame = webView:frame()
          local x = screenFrame.w - webViewFrame.w
          local newY = screenFrame.y + ((screenFrame.h - webViewFrame.h) / 2)
          webView:topLeft({ x = x, y = newY })
        end))
    end
end


local function disableWebViewHotkeys()
    for _, hotkey in ipairs(webViewHotkeys) do
        hotkey:delete()
    end
    webViewHotkeys = {}
end

local function toggleWebView()
    if webView:isVisible() then
        webView:hide()
        if outsideClickWatcher then
            outsideClickWatcher:stop()
            outsideClickWatcher = nil
        end
        disableWebViewHotkeys()
    else
        local menuBarFrame = menuBarItem:frame()
        local x = menuBarFrame.x - 400
        local y = menuBarFrame.h
        webView:frame({ w = 800, h = 600 })
        webView:topLeft({x = x, y = y})
        webView:show()
        webView:bringToFront(true)
        enableWebViewHotkeys()
    end
end

menuBarItem:setTitle("k")
menuBarItem:setClickCallback(toggleWebView)
hs.hotkey.bind({"cmd", "alt"}, "K", toggleWebView)
