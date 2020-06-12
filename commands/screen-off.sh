#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    osascript -e 'tell app "Finder" to sleep'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    notify-send -t 1500 "Display manager" "Monitor powering down"
    sleep 2 && xset dpms force off
fi
