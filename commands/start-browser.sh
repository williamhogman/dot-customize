#!/bin/sh

#
# Launches the browser with the passed in options
#

if [ "$(uname)" == "Darwin" ]; then
    open $@
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    $BROWSER $@
fi
