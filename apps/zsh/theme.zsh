#!/bin/zsh
# https://github.com/blinks zsh theme

if [[ $TERM == "emacs" ]]; then
    PROMPT="➜"
else
    PROMPT='%{$fg_bold[red]%}➜%{$reset_color%}'
    RPROMPT='%b%{$fg_bold[red]%}%c%{$reset_color%}'
fi
