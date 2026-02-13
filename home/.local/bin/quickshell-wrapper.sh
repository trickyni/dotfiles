#!/usr/bin/env bash
if pgrep -x quickshell; then
    killall quickshell
fi
sway exec quickshell
