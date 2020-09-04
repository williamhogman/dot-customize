#!/usr/bin/env bash
# This bootstraps the dot-customize environment 
# which downloads stuff from GH and runs it

set -e

mkdir -p ~/code/

if [ ! -d "~/code/dot-customize" ] 
then
git clone https://github.com/williamhogman/dot-customize.git ~/code/dot-customize
fi

cd ~/code/dot-customize

exec ./install