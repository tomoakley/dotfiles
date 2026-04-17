#!/bin/bash
# Highlights the active space
if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" background.drawing=on
else
  sketchybar --set "$NAME" background.drawing=off
fi
