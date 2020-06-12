#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    # TODO: Mac keyboard setup
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    setxkbmap se
    xmodmap "$C_HOME/keyboards/$C_KEYBOARD"
fi
