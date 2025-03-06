# dotfiles

Software developer for TotallyMoney, working as a React Native/front-end engineer, this repo contains the dotfiles for all the software I use. There's some unusual and weird things in here; I've explained the main things below:

## Alacritty
Terminal emulator of choice. I like the GPU-driven speedy UI, the "do one thing, do it well" approach and the customisability of it.

## Neovim
I spend most of my day in Neovim, to write code and review PRs through octo.nvim. I have a custom script in Qutebrowser's config to detect if I'm on a Github PR page, check if I have the repo cloned locally and if I do, open the PR in octo.nvim.

## Tmux
I use tmux constantly to create sessions for each repo/directory. I use tmux-sessionizer to do this for me and have some other bindings to help me. I have an internal script for the repos I use at TotallyMoney to spin up the docker codebases for the backend, run the app, create new user accounts in my local environment, kill the mock servers and restart them and more - these scripts use tmux commands heavily to automate this. I have some tmux plugins, notably tmux-1password to enable me to get passwords/OTPs easily and copy them to the clipboard.

## Weechat
I often use Slack in Weechat, as I don't like the distracting and attention-seeking UI in Slack's electron app (plus means I don't need to run another electron app). I struggle to use this consistently however. I wrote my own script, tmux-weechat, for toggling a weechat pane in whatever tmux session I'm in, and bound it to `<c-b>a` in tmux.

## Qutebrowser
My browser of choice. I love the customisable UI, the ability to have vertical tabs and hide the tab bar to reduce the window chrome. And obviously the vim-like UX! I have some custom commands to redirect Youtube/Reddit links to privacy-protecting alternatives.

## Hammerspoon
I use this to add useful keybindings and do cool stuff with URLs; hammerspoon is set as my Mac's default browser so it picks up URLs. In the URL module there is then some rules - Github PR URLs (either /pulls or /pull/{id} are sent to Alacritty and a shell script is run to open the PR in octo.nvim, where I can review it from the comfort of my own neovim config.) There is also some URL config to open specific URLS in Safari rather than Qutebrowser; some of these Safari URLs I have saved as Safari Web apps (Notion/Sentry/Figma). MacOS is smart enough to open the links in the web app rather than Safari!

I have also added some Hammerspoon config to show kagi.com/assistant webview via a menu bar app using a keybinding. This is so useful as I can talk to AI at a moment's notice. I have added some useful keybindings here to prevent needing to use the mouse.

## Other tools not in dotfiles:
- *[Homerow](https://www.homerow.app/)* - use hints (like Qutebrowser or Vimari/Vimium) in the Mac UI, scroll with the j/k on the keyboard and search for elements. Successor to vimac which I loved.
- *[OrbStack](https://orbstack.dev/)* - drop-in replacement for Docker Desktop. Nicer, SwiftUI app and less memory usage for containers

## Things I'm exploring
- *gh-dash* - Dashboard for Github PRs/Issues
- *Alfred* - I love it but again, similar to Hammerspoon, can't seem to work into my daily workflow

I also have a weird keyboard but that's a story for another day.
