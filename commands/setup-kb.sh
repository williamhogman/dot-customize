#!/bin/sh
# don't source this!

source $C_HOME/lib/all.sh


# no need to run this on Mac OS
c_dont_run_on_mac;



# Swedish layout
setxkbmap se

# Fixes by keyboard model

xmodmap "$C_HOME/keyboards/$C_KEYBOARD"
