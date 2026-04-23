#!/usr/bin/env bash
if pgrep -x quickshell; then
  killall quickshell
fi
quickshell --daemonize --no-duplicates
# niri msg action spawn-sh -- "quickshell --no-duplicate --daemonize"
