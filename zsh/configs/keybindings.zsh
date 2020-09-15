export KEYTIMEOUT=1 # reduce key delay to 0.1s

# Use vim cli mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
