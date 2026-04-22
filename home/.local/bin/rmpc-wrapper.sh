#!/usr/bin/env bash
if pgrep -x rmpc; then
  killall rmpc
else
  gtk-launch rmpc
fi
