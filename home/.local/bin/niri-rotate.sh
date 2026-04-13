#!/usr/bin/env bash
state=$(niri msg focused-output | rg -i transform | awk '{print $2}')
if [ "$state" == "normal" ]; then
  niri msg action do-screen-transition --delay-ms 150
  niri msg output eDP-1 transform 90
else
  niri msg action do-screen-transition --delay-ms 150
  niri msg output eDP-1 transform normal
fi
