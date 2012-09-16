#!/bin/zsh

DIR="$(realpath $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"

LIBS=$(realpath "$DIR/../lib/")
fpath=($fpath $LIBS)

autoload -U c_on_a_mac

res=$(c_on_a_mac)

if [ $(c_on_a_mac) -eq 1 ]; then
    osascript -e 'tell app "Finder" to sleep'
else
    notify-send -t 1500 "Display manager" "Monitor powering down"
    sleep 2 && xset dpms force off
fi



