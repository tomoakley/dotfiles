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
curl https://gist.githubusercontent.com/mvanbaak/e98b7b622ea2c8ab626d51cb88e27406/raw/4ceb0e5288c912f9373b4e80673370cd9fc9fe2d/gistfile1.txt >> macos
chmod +x macos.sh
./macos.sh
rm macos.sh


