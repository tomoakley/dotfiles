hs.hints.hintChars = "ASDFGHJKLQWERTYUIOP"  -- Characters to use for hints
hs.hints.style = "vimperator"  -- Use vimperator style hints
hs.hints.showTitleThresh = 10  -- Show window titles when fewer than 10 windows

hs.hotkey.bind({"ctrl"}, "f", function()
  hs.hints.windowHints()
end)
