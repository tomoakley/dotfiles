#!/bin/bash
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | head -1 | tr -d '%')
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄"
elif [[ "$PERCENTAGE" -gt 80 ]]; then
  ICON="󰁹"
elif [[ "$PERCENTAGE" -gt 50 ]]; then
  ICON="󰁾"
elif [[ "$PERCENTAGE" -gt 20 ]]; then
  ICON="󰁼"
else
  ICON="󰁺"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
