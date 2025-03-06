local menuBarItem = hs.menubar.new()

-- Create a WebView
local webView = hs.webview.new({x = 0, y = 0, w = 800, h = 600})
    :windowStyle("resizable")
    :allowGestures(true)
    :allowTextEntry(true)  -- Allow the WebView to behave like a standard window
    :level(hs.drawing.windowLevels.modalPanel)
    :closeOnEscape(true)
    :url("https://www.kagi.com/assistant")

webView:shadow(true)

local webViewHotkeys = {}

local function enableWebViewHotkeys()
    if #webViewHotkeys == 0 then
        -- Define hotkeys specific to the WebView
        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "N", function()
            local jsCode = [[
              var button = document.querySelector('[title="New Thread"]');
              if (button) {
                  button.click();
              }
            ]]
            webView:evaluateJavaScript(jsCode)  -- Copy selected text
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "H", function()
            local jsCode = [[
                var button = document.querySelector("#thread-sidebar-expand")
                if (button) {
                    button.click();
                }
            ]]
            webView:evaluateJavaScript(jsCode)  -- Copy selected text
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd"}, "I", function()
          local frame = webView:frame()
          local point = hs.geometry.point((frame.x + frame.w)/2, (frame.y + frame.h)/2) -- Replace with the coordinates of your textarea
          hs.eventtap.leftClick(point)
        end))

        table.insert(webViewHotkeys, hs.hotkey.bind({"cmd", "alt"}, "Q", function()
            webView:hide()
            disableWebViewHotkeys()  -- Disable hotkeys when hiding the WebView
        end))
    end
end


local function disableWebViewHotkeys()
    for _, hotkey in ipairs(webViewHotkeys) do
        hotkey:delete()  -- Disable and delete the hotkey
    end
    webViewHotkeys = {}  -- Clear the hotkey list
end

-- Function to toggle the WebView

local function toggleWebView()
    if webView:isVisible() then
        webView:hide()
        if outsideClickWatcher then
            outsideClickWatcher:stop()
            outsideClickWatcher = nil
        end
        disableWebViewHotkeys()  -- Disable WebView-specific hotkeys
    else
        local screenFrame = hs.screen.mainScreen():frame()
        local menuBarFrame = menuBarItem:frame()
        local x = menuBarFrame.x - 400
        local y = menuBarFrame.h
        webView:topLeft({x = x, y = y})
        webView:show()
        webView:bringToFront(true)
        enableWebViewHotkeys()  -- Enable WebView-specific hotkeys
    end
end

-- Set up the menu bar item
menuBarItem:setTitle("🌐")
menuBarItem:setClickCallback(toggleWebView)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", toggleWebView)
