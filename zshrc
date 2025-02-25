# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi
#
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# only check once per day for cached .zcompdump file to see if it must be regenerated
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# set tmux-spotify to use Apple Music instead of Spotify
export MUSIC_APP="iTunes"

# set env vars for critiq.vim to be able to talk to GitHub
export GITHUB_TOKEN=$(security find-generic-password -w -a ${USER} -D "environment variable" -s "github.com")

# source antibody plugins
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
antidote load ~/.zsh/zsh_plugins.txt

source ~/.zsh/aliases
source ~/.zsh/configs/ohmyzsh.zsh
#source ~/.zsh/configs/nvm.zsh
source ~/.zsh/configs/android.zsh
source ~/.zsh/configs/keybindings.zsh
[ -f ~/.zsh/configs/fzf.zsh ] && source ~/.zsh/configs/fzf.zsh
eval "$(fnm env --use-on-cd)"

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

source $ZSH/oh-my-zsh.sh

dcleanup() {
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rm $(docker ps -a -q)
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
    docker volume rm $(docker volume ls -qf dangling=true)
}

# if command -v pyenv 1>/dev/null 2>&1; then
#   export PYENV_ROOT="$HOME/.pyenv"
#   export PATH="$PYENV_ROOT/bin:$PATH"
#   export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
#   eval "$(pyenv init --path)"
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# fi

#zprof # bottom of .zshrc

# To customize prompt, run `p10k configure` or edit ~/.zsh/p10k.zsh.
POWERLEVEL9K_CONFIG_FILE=~/.zsh/p10k.zsh
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
if [ -e /Users/tomoakley/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tomoakley/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/libressl/bin:$PATH"
export PATH=$PATH:$HOME/.maestro/bin

# flashlight
export PATH="$PATH:$HOME/.flashlight/bin"
