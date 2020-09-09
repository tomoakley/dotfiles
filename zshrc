# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# only check once per day for cached .zcompdump file to see if it must be regenerated
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# source anitgen plugins
source ~/.dotfiles/zsh_plugins.sh

# oh-my-zsh settings
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=true

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set fzf to use ripgrep in vim
export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'

# lazy load nvm using zsh-nvm
export NVM_LAZY_LOAD=true

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

# custom stuff
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias v="nvim"
else
  alias v="vim"
fi

alias r="ranger"

alias b="buku"
alias bt="buku -t" # alias to search buku tags
alias btf="buku -t favourites" # alias to show buku favourites
alias ba="buku -a" # alias to add buku bookmark
alias baf='f() { buku -a $1 favourites --title $2 };f'

alias ab='echo "Refreshing antibody plugins..."; antibody bundle < ~/.dotfiles/zsh_plugins.txt > ~/.dotfiles/zsh_plugins.sh; source ~/.zshrc'

# if buku bookmarks.db has changed, autocommit
# credit: https://github.com/jarun/buku/issues/308
buku() {
    command buku $@
    sh -c 'cd ~/.local/share/buku; if git status -s | grep -q -E "^\s+M\s"; then git commit -a -m "autocommit $(date)" 1>/dev/null && echo "committed change"; fi'
}

# Make directory and change into it.
# https://github.com/thoughtbot/dotfiles/blob/master/zsh/functions/mcd
function mcd() {
  mkdir -p "$1" && cd "$1";
}

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#zprof # bottom of .zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
