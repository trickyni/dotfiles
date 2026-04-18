#!/usr/bin/env bash
if pgrep -x quickshell; then
  killall quickshell
fi
# quickshell --no-duplicate --daemonize
niri msg action spawn-sh -- "quickshell --no-duplicate --daemonize"
