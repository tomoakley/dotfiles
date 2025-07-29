# Hammerspoon

I have been using Hammerspoon an increasing amount to automate some things and change behaviour of some apps and services, or add functionality. Here I will describe some of this.

## [Chrome](https://github.com/tomoakley/dotfiles/blob/master/hammerspoon/chrome.lua)
At work we are required to use Google Chrome (or Edge), meaning I am unable to use my beloved Qutebrowser. I have a lot of muscle memory with QB, such as `J|K` to move tabs, `j|k` to scroll, `H/L` to move back/forward in browser history, `d` to close, `o|O` to open a new URL, and of course the keyboard hints for interactive elements. We are also unable to use Vimium, the Chrome extension that adds keyboard hints.

To combat all of this, I have written some [Hammerspoon config](https://github.com/tomoakley/dotfiles/blob/master/hammerspoon/chrome.lua) to emulate these keybindings when the Chrome window is active. The tricky part is trying to make sure that a currently focussed element on the webpage is not a textfield or something I can type in. I have added some element types, using the accessibility roles, but some things are still problematic - mostly webpages with interactive dropdown menus (e.g GitHub's "find files" dropdown).

Some of these keybindings just call Chrome shortcuts e.g `H` just calls `cmd+[` to go back a page in history. The scroll events on `j` and `k` use the Hammerspoon API for scrolling. To show the keyboard hints, I can press `f` and it will invoke the Homerow keyboard shortcut to show the hints.

## [URLs](https://github.com/tomoakley/dotfiles/blob/master/hammerspoon/url.lua)
This config enables me to do some cool stuff with URLs. The same config exists in Qutebrowser, but had to move a lot of it to HS (which is probably better anyway). The most useful bit here is the ability to take a github.com URL and pass it to a bash script (still in Qutebrowser directory), which checks if the repo in question is cloned locally, and if it is, move to that session in Tmux (via tmux-sessionizer, or open new session if not already open), open a new pane and open the PR in octo.nvim. This means I can review the PR in octo.nvim without it even loading in Chrome, which is wonderful.

There are also configs to redirect lots of social media sites to privacy-protecting alternatives; I haven't quite gotten around to making these work with Chrome yet. Finally, there is some config to open some specific URLs in Safari - these won't actually open the Safari browser (as it's blocked anyway on my work Mac), but the saved web apps still open which is great!

## [Kagi Assistant webview](https://github.com/tomoakley/dotfiles/blob/master/hammerspoon/menubar/kagi.lua)
I have written a small little menubar app in Hammerspoon that shows the Kagi Assistant webview, meaning I can ask it whatever I need without needing to navigate to the website. Super helpful.

## Others
There are some other things here, such as the wonderful [VimMode spoon](https://github.com/dbalatero/VimMode.spoon) that I haven't yet fully integrated into workflow, but I do intend to at some point, and other things that I've tried and left for now.
