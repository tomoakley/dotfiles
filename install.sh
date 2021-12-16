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

## setup dotfiles correctly
dotbot -c install.conf.yaml

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# generate antibody zsh plugins shell file
antibody bundle < ~/.zsh/zsh_plugins.txt > ~/.zsh/zsh_plugins.sh

# install tmux-plugin-manager and then install the plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/scripts/update_plugin.sh
~/.tmux/plugins/tpm/scripts/update_plugin.sh

# install vimplug and then install the plugins
sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +'PlugInstall --sync' +qa

# get Meslo font. These need installing manually
cd ~/Downloads && {
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Regular.ttf'
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Bold.ttf'
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Italic.ttf'
    curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Bold Italic.ttf'
    cd -; }

# set some better macos defaults
chmod +x macos.sh
./macos.sh

# clone (private) buku bookmarks db
git clone https://github.com/tomoakley/buku-bookmarks ~/.local/share/buku/

# symlink userscripts to Qutebrowser data directory, run buku-get to import buku bookmarks into qb
ln -s ~/dotfiles/qutebrowser/userscripts ~/Library/Application\ Support/qutebrowser/userscripts
~/dotfiles/qutebrowser/userscripts/buku-get
