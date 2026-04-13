#!/usr/bin/env bash
state=$(niri msg focused-output | rg -i scale | awk '{print $2}')
if [ "$state" == "1.5" ]; then
  niri msg action do-screen-transition
  niri msg output eDP-1 scale 1
  qs ipc call panel scale 1.5 #FIX values should be swapped for better readability
else
  niri msg action do-screen-transition
  niri msg output eDP-1 scale 1.5
  qs ipc call panel scale 1 #FIX
fi
