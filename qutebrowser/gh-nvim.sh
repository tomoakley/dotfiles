#!/usr/bin/env bash

URL=$1 # github.com/mediaingenuity/Account_NativeApp/pulls

# ${MYVAR#pattern}     # delete shortest match of pattern from the beginning
# ${MYVAR##pattern}    # delete longest match of pattern from the beginning
# ${MYVAR%pattern}     # delete shortest match of pattern from the end
# ${MYVAR%%pattern}    # delete longest match of pattern from the end

# TMUX_SESSION=$(basename "$REPO" | tr . _)
# echo $TMUX_SESSION
open -a alacritty

WINDOW_NAME="PRs"

REPO=$(echo "$URL" | awk -F/ '{print $5}')
TMUX_SESSION=$(echo "$REPO" | sed 's/\./\_/g')
#PR_NUMBER=$(echo "$URL" | awk -F/ '{print $7}')

WINDOW_ID=$(/opt/homebrew/bin/tmux list-windows -t "$TMUX_SESSION" -F "#{window_name}, #{window_id}" | grep "$WINDOW_NAME" | awk -F ', ' '{print $2}')
if [[ -n $WINDOW_ID ]]; then
  /opt/homebrew/bin/tmux kill-window -t "$WINDOW_ID"
fi

/opt/homebrew/bin/tmux new-window -n "$WINDOW_NAME" -t "$TMUX_SESSION" -c ~/code/$REPO

if [[ -z $PR_NUMBER ]]; then
  /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=PRs"
  /opt/homebrew/bin/tmux send-keys -t "=$TMUX_SESSION:=$WINDOW_NAME" '/opt/homebrew/bin/nvim -c ":silent Octo pr list"' Enter
# else
#   /opt/homebrew/bin/tmux send-keys -t '=dotfiles:=3' '/opt/homebrew/bin/nvim -c ":silent Octo pr edit 7367"' Enter
fi
