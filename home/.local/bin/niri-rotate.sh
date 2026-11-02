#!/usr/bin/env bash
state=$(niri msg focused-output | rg -i transform | awk '{print $2}')
focus=$(niri msg focused-output | rg -so '\w*DP-\d')
if [ "$state" == "normal" ]; then
  niri msg action do-screen-transition --delay-ms 150
  niri msg output "$focus" transform 90
  echo "$focus"
else
  niri msg action do-screen-transition --delay-ms 150
  niri msg output "$focus" transform normal
fi
