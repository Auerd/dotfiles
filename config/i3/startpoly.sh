#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)

if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
  MONITOR=$(polybar --list-monitors | cut -d":" -f1) polybar --reload &
else
  primary=$(xrandr --query | grep primary | cut -d" " -f1)

  for m in $screens; do
    if [[ $primary == "$m" ]]; then
        MONITOR=$m polybar --reload &
    else
        MONITOR=$m polybar --reload &
    fi
  done
fi
