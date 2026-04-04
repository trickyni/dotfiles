#!/usr/bin/env bash
if pgrep -x quickshell; then
  killall quickshell
fi
niri msg action spawn -- "quickshell"
