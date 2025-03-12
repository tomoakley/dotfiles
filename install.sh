#!/usr/bin/env bash

# Install Homebrew
sudo chown -R $(whoami):admin /usr/local
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor
brew update

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install packages from brewfile
brew bundle

# setup fnm and node version
curl -fsSL https://fnm.vercel.app/install | bash
fnm install 20
fnm use 20

# install global npm packages
npm i -g typescript typescript-language-server
npm i -g @vtsls/language-server
npm i -g readability-cli
npm i -g @sloansparger/bear
npm i -g vscode-langservers-extracted

## setup dotfiles correctly
dotbot -c install.conf.yaml

# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# generate antibody zsh plugins shell file
antidote bundle < ~/.zsh/zsh_plugins.txt > ~/.zsh/zsh_plugins.sh

# install tmux-plugin-manager and then install the plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
chmod +x ~/.tmux/plugins/tpm/scripts/update_plugin.sh
~/.tmux/plugins/tpm/scripts/update_plugin.sh

# get Meslo font. These need installing manually
# now done via homebrew but left here in case
# cd ~/Downloads && {
#     curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Regular.ttf'
#     curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Bold.ttf'
#     curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Italic.ttf'
#     curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF Bold Italic.ttf'
#     cd -; }

# set some better macos defaults
chmod +x macos.sh
./macos.sh

# clone (private) buku bookmarks db
git clone https://github.com/tomoakley/buku-bookmarks ~/.local/share/buku/

# symlink userscripts to Qutebrowser data directory, run buku-get to import buku bookmarks into qb
ln -s ~/dotfiles/qutebrowser/userscripts ~/Library/Application\ Support/qutebrowser/userscripts
~/dotfiles/qutebrowser/userscripts/buku-get

git clone https://github.com/mcthomas/Apple-Music-CLI-Player
cd Apple-Music-CLI-Player/src
chmod +x am.sh
mv am.sh /usr/local/bin/am
fd ../../
rm -rf Apple-Music-CLI-Player

# gh cli
echo '//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
@mediaingenuity:registry=https://npm.pkg.github.com/' >> ~/.npmrc

gh auth login
gh extension install dlvhdr/gh-dash

ln -s ~/dotfiles/gh-dash ~/.config/gh-dash

# install Hammerspoon spoons
git clone https://github.com/dbalatero/VimMode.spoon ~/code/dotfiles/hammerspoon/Spoons/VimMode.spoon
