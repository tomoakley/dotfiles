#!/usr/bin/env bash

QT_URL=$1 # PyQt6.QtCore.QUrl('https://github.com/owner/repo/pulls')
URL=$(echo $QT_URL | sed -n 's/^.*'\''\(.*\)'\''.*$/\1/p') # extract url out of above string

# ${MYVAR#pattern}     # delete shortest match of pattern from the beginning
# ${MYVAR##pattern}    # delete longest match of pattern from the beginning
# ${MYVAR%pattern}     # delete shortest match of pattern from the end
# ${MYVAR%%pattern}    # delete longest match of pattern from the end

# TMUX_SESSION=$(basename "$REPO" | tr . _)
# echo $TMUX_SESSION
open -a alacritty


REPO=$(echo "$URL" | awk -F/ '{print $5}')
TMUX_SESSION=$(echo "$REPO" | sed 's/\./\_/g')
PR_NUMBER=$(echo "$URL" | awk -F/ '{print $7}')


if [[ -z $PR_NUMBER ]]; then
  WINDOW_NAME="PRs"
  WINDOW_ID=$(/opt/homebrew/bin/tmux list-windows -t "$TMUX_SESSION" -F "#{window_name}, #{window_id}" | grep "$WINDOW_NAME" | awk -F ', ' '{print $2}')
  if [[ -n $WINDOW_ID ]]; then
    /opt/homebrew/bin/tmux kill-window -t "$WINDOW_ID"
  fi
  /opt/homebrew/bin/tmux new-window -n "$WINDOW_NAME" -t "$TMUX_SESSION" -c ~/code/$REPO
  /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
  /opt/homebrew/bin/tmux send-keys -t "=$TMUX_SESSION:=$WINDOW_NAME" '/opt/homebrew/bin/nvim -c ":silent Octo pr list"' Enter
else
  WINDOW_NAME="PR: $PR_NUMBER"
  WINDOW_ID=$(/opt/homebrew/bin/tmux list-windows -t "$TMUX_SESSION" -F "#{window_name}, #{window_id}" | grep "$WINDOW_NAME" | awk -F ', ' '{print $2}')
  if [[ -n $WINDOW_ID ]]; then
    /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
  else
    /opt/homebrew/bin/tmux new-window -n "$WINDOW_NAME" -t "$TMUX_SESSION" -c ~/code/$REPO
    /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
    /opt/homebrew/bin/tmux send-keys -t "=$TMUX_SESSION:=$WINDOW_NAME" "/opt/homebrew/bin/nvim -c ':silent Octo pr edit $PR_NUMBER'" Enter
  fi
fi
