#!/usr/bin/env bash
prevwc=$(echo "$line" | awk '{print $2}') || 0
echo -e "\e[38;5;4mS M T W T F S\e[0m"
ticker=1
while IFS= read -r line; do
  curwc=$(echo "$line" | awk '{print $2}')
  block="██"
  background=0
  if [ "$curwc" == "-" ]; then
    color=18
  elif [[ $curwc -ge 800 ]]; then
    color=6
  elif [[ $curwc -ge 500 ]]; then
    color=2
  elif [[ $curwc -ge 200 ]]; then
    color=4
  elif [[ $curwc -lt 200 ]]; then
    if [[ $prevwc-500 -ge 300 ]]; then
      block="🬸█"
      background=6
      color=4
    elif [[ $prevwc-500 -ge 200 ]]; then
      block="🬸█"
      background=2
      color=4
    else
      color=1
    fi
  fi
  prevwc=$curwc
  echo -en "\e[38;5;${color};48;5;${background}m${block}\
\e[0m"
  if ! ((ticker % 7)); then
    echo ""
  fi
  ((ticker++))
done <~/Documents/_wc/ricka_writing_tracking
