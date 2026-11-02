#!/usr/bin/env bash
orientation=$(niri msg focused-output | rg -i transform | awk '{print $2}')
scale=$(niri msg focused-output | rg -i scale | awk '{print $2}')
focus=$(niri msg focused-output | rg -so '\w*DP-\d')
case "$1" in
rotate)
  if [ "$orientation" == "normal" ]; then
    niri msg output "$focus" transform 90
    echo "$focus"
  else
    niri msg output "$focus" transform normal
  fi
  ;;
scale)
  if [ "$scale" == "1.5" ]; then
    niri msg output "$focus" scale 1
    qs ipc call panel scale 1.5 #FIX values should be swapped for better readability
  else
    niri msg output "$focus" scale 1.5
    qs ipc call panel scale 1 #FIX
  fi
  ;;
esac
