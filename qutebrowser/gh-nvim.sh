#!/usr/bin/env bash

URL=$1 # github.com/mediaingenuity/Account_NativeApp/pulls

# ${MYVAR#pattern}     # delete shortest match of pattern from the beginning
# ${MYVAR##pattern}    # delete longest match of pattern from the beginning
# ${MYVAR%pattern}     # delete shortest match of pattern from the end
# ${MYVAR%%pattern}    # delete longest match of pattern from the end

# PATH=${URL#*/}
# PATH2=${PATH#*/}
# REPO=${PATH2%/*}
# TMUX_SESSION=$(basename "$REPO" | tr . _)
# echo $TMUX_SESSION
open -a alacritty


# tmux switch -t Account_NativeApp
