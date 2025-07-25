#!/usr/bin/env bash

# todo:
# - custom bindings for octo
# - open individual PRs in the same tmux window
# - binding to return to previously active tmux session/window

URL=$1

# if launching from Qutebrowser, do this to extract URL out of the $QT_URL variable which looks like # PyQt6.QtCore.QUrl('https://github.com/owner/repo/pulls')
# if [[ $URL =~ ^PyQt6\.QtCore\.QUrl\('.*'\)$ ]]; then
#URL=$(echo "$URL" | sed -n 's/^.*'\''\(.*\)'\''.*$/\1/p')
# fi

REPO=$(echo "$URL" | awk -F/ '{print $5}')
PATH_TO_REPO=~/code/$REPO

if [ ! -e $PATH_TO_REPO ]; then
  exit
fi

open -a alacritty

TMUX_SESSION=$(echo "$REPO" | sed 's/\./\_/g')
PR_NUMBER=$(echo "$URL" | awk -F/ '{print $7}')

if [[ -z $PR_NUMBER ]]; then
  WINDOW_NAME="PRs"
  WINDOW_ID=$(/opt/homebrew/bin/tmux list-windows -t "$TMUX_SESSION" -F "#{window_name}, #{window_id}" | grep "$WINDOW_NAME" | awk -F ', ' '{print $2}')
  if [[ -n $WINDOW_ID ]]; then
    /opt/homebrew/bin/tmux kill-window -t "$WINDOW_ID"
  fi
  /opt/homebrew/bin/tmux new-window -n "$WINDOW_NAME" -t "$TMUX_SESSION" -c $PATH_TO_REPO
  /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
  /opt/homebrew/bin/tmux send-keys -t "=$TMUX_SESSION:=$WINDOW_NAME" '/opt/homebrew/bin/nvim -c ":silent Octo pr list"' Enter
else
  WINDOW_NAME="PR: $PR_NUMBER"
  WINDOW_ID=$(/opt/homebrew/bin/tmux list-windows -t "$TMUX_SESSION" -F "#{window_name}, #{window_id}" | grep "$WINDOW_NAME" | awk -F ', ' '{print $2}')
  if [[ -n $WINDOW_ID ]]; then
    /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
  else
    /opt/homebrew/bin/tmux new-window -n "$WINDOW_NAME" -t "$TMUX_SESSION" -c $PATH_TO_REPO
    /opt/homebrew/bin/tmux switch-client -t "=$TMUX_SESSION:=$WINDOW_NAME"
    /opt/homebrew/bin/tmux send-keys -t "=$TMUX_SESSION:=$WINDOW_NAME" "\/opt/homebrew/bin/nvim -c ':silent Octo pr edit $PR_NUMBER'" Enter
  fi
fi
