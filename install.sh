#!/usr/bin/env bash

## Install Homebrew
sudo chown -R $(whoami):admin /usr/local
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update

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
