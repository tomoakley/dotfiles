# dotfiles

Software developer for TotallyMoney, working as a React Native/front-end engineer, this repo contains the dotfiles for all the software I use. There's some unusual and weird things in here; I've explained the main things below:

## Alacritty
Terminal emulator of choice. I like the GPU-driven speedy UI, the "do one thing, do it well" approach and the customisability of it.

## Neovim
I spend most of my day in Neovim, to write code and review PRs through octo.nvim. I have a custom script in Qutebrowser's config to detect if I'm on a Github PR page, check if I have the repo cloned locally and if I do, open the PR in octo.nvim.

## Tmux
I use tmux constantly to create sessions for each repo/directory. I use tmux-sessionizer to do this for me and have some other bindings to help me. I have an internal script for the repos I use at TotallyMoney to spin up the docker codebases for the backend, run the app, create new user accounts in my local environment, kill the mock servers and restart them and more - these scripts use tmux commands heavily to automate this.

## Weechat
I often use Slack in Weechat, as I don't like the distracting and attention-seeking UI in Slack's electron app (plus means I don't need to run another electron app). I struggle to use this consistently however. I wrote my own script, tmux-weechat, for toggling a weechat pane in whatever tmux session I'm in, and bound it to `<c-b>a` in tmux.

## Qutebrowser
My browser of choice. I love the customisable UI, the ability to have vertical tabs and hide the tab bar to reduce the window chrome. And obviously the vim-like UX! I have some custom commands to redirect Youtube/Reddit links to privacy-protecting alternatives.

## Other tools not in dotfiles:
- *[Choosy](https://choosy.app/)* - open different links in different browsers. Write customisable rules to do this, filtering by URL, source app etc. For example, at TotallyMoney we can only access Google Drive URLs in Google Chrome. If I try to use Qutebrowser or Safari, I'll get a permissions error. So I wrote a rule to say if it's a google link, open in Chrome. Another example is Figma - it doesn't work well in Qutebrowser, so I have a custom rule that Figma link opens in Safari.
- *[Vimac](https://github.com/nchudleigh/vimac)* - use hints (like Qutebrowser or Vimari/Vimium) in the Mac UI
- *[OrbStack](https://orbstack.dev/)* - drop-in replacement for Docker Desktop. Nicer, SwiftUI app and less memory usage for containers

## Things I'm exploring
- *Hammerspoon* - trying to adopt this for automation. It's great but just can't fit the things into my workflow currently
- *gh-dash* - Dashboard for Github PRs/Issues
- *Alfred* - I love it but again, similar to Hammerspoon, can't seem to work into my daily workflow

I also have a weird keyboard but that's a story for another day.
