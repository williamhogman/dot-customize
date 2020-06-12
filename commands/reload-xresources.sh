#!/usr/bin/env bash

echo "Reloading xresources"
cd $C_HOME/config
xrdb -load Xresources
