#!/usr/bin/env bash

# Shamlessly stolen from: jimeh/dotfiles <3

# If reattach-to-user-namespace is not available, just run the command.
if [ -n "$(command -v reattach-to-user-namespace)" ]; then
    reattach-to-user-namespace $@
else
    exec "$@"
fi
