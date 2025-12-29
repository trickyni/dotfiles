#!/usr/bin/env bash

#xorg version
# date -I | xclip -sel c -in
# xdotool key --clearmodifiers ctrl+v

# date -I | tr -d '\n' | wl-copy
echo -n $(date -I) | wl-copy

