# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# only check once per day for cached .zcompdump file to see if it must be regenerated
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# source anitgen plugins
source ~/.zsh/zsh_plugins.sh

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

source $ZSH/oh-my-zsh.sh

source ~/.zsh/configs/ohmyzsh.zsh
source ~/.zsh/configs/nvm.zsh
source ~/.zsh/configs/android.zsh
source ~/.zsh/configs/keybindings.zsh
[ -f ~/.zsh/configs/fzf.zsh ] && source ~/.zsh/configs/fzf.zsh

source ~/.zsh/aliases

#zprof # bottom of .zshrc

# To customize prompt, run `p10k configure` or edit ~/.zsh/p10k.zsh.
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
