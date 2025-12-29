#!/usr/bin/env bash
if pgrep -x fuzzel; then
    killall fuzzel
else
    fuzzel
fi
