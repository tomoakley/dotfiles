#!/usr/bin/env bash

## Install Homebrew
sudo chown -R $(whoami):admin /usr/local
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

## Install packages from brewfile
brew bundle

## setup nvm and node versions
mkdir ~/.nvm/
chmod +x /usr/local/opt/nvm/nvm.sh

nvm install 12
nvm use 12
nvm alias default 10

# install tmux-plugin-manager and then install the plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/scripts/update_plugin.sh
~/.tmux/plugins/tpm/scripts/update_plugin.sh

# install vimplug and then install the plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim +'PlugInstall --sync' +qa

## setup dotfiles correctly
dotbot -c install.conf.yaml
