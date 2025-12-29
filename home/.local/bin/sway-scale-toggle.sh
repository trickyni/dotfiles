#!/usr/bin/env bash
qsScale() {
  # tell sway proc to run it since 'qs' links against a tonne of things
  # and steam doesn't like that...
  swaymsg 'exec "qs ipc call panel scale '$1'"'
}
case "$1" in
"")
  current_scale=$(swaymsg -t get_outputs | grep '"scale": ' | sed -n 's/[^0-9.]*\([0-9]\+\(\.[0-9]\+\)\?\).*/\1/p')
  if [ "$current_scale" == 1.5 ]; then
    swaymsg 'output * scale 1.0'
    qsScale 1.5 #values are inverse because quickshell's default is 1.5 scaled. might change later.
  else
    swaymsg 'output * scale 1.5'
    qsScale 1.0
  fi
  ;;
gameon)
  swaymsg 'output * scale 1.0'
  qsScale 1.5

  ;;
gameoff)
  swaymsg 'output * scale 1.5'
  qsScale 1.0
  ;;
esac
