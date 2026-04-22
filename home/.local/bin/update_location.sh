#!/usr/bin/env bash
echo -n $(curl --fail https://ipapi.co/latlong | sed 's/,/N /') >~/.location
echo E >>~/.location
