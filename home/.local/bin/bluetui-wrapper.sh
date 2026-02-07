#!/usr/bin/env bash
if pgrep -x quickshell; then
    killall quickshell
    swaymsg exec quickshell
else
    swamsg exec quickshell
fi
