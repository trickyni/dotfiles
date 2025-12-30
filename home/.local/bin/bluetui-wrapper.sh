#!/usr/bin/env bash
if pgrep -x bluetui; then
    killall bluetui
else
    gtk-launch bluetui
fi
