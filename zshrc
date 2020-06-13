# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set fzf to use ripgrep in vim
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# Set Pass to enable extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Set Android SDK root and add emulator to $PATH for easy use
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools:$PATH

bindkey -v
export KEYTIMEOUT=1 # reduce key delay to 0.1s

# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# vi() {
  #spaceship_vi_mode_enable
#}

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zgen oh-my-zsh
zgen oh-my-zsh plugins/git
zgen oh-my-zsh plugins/osx
zgen oh-my-zsh plugins/sudo
zgen oh-my-zsh plugins/npm
zgen oh-my-zsh plugins/brew
zgen oh-my-zsh plugins/docker-compose
zgen oh-my-zsh plugins/yarn
zgen oh-my-zsh plugins/tmux

zgen load denysdovhan/spaceship-prompt spaceship
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-autosuggestions
zgen load djui/alias-tips
zgen load softmoth/zsh-vim-mode
zgen load wfxr/forgit

# custom stuff

alias v="vim"

alias r="ranger"

alias b="buku"
alias bt="buku -t" # alias to search buku tags
alias btf="buku -t favourites" # alias to show buku favourites
alias ba="buku -a" # alias to add buku bookmark
alias baf='f() { buku -a $1 favourites --title $2 };f'

# if buku bookmarks.db has changed, autocommit
# credit: https://github.com/jarun/buku/issues/308
buku() {
    command buku $@
    sh -c 'cd ~/.local/share/buku; if git status -s | grep -q -E "^\s+M\s"; then git commit -a -m "autocommit $(date)" 1>/dev/null && echo "committed change"; fi'
}

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
