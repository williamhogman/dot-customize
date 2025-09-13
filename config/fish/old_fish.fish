set fish_greeting
set -x GPG_TTY (tty)
set pipenv_fish_fancy yes
set -x ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES
set -x VISUAL "emacsclient -a nano -q"
set -x EDITOR $VISUAL
set -x SSH_AUTH_SOCK /Users/whn/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
set -x PNPM_HOME "/Users/whn/Library/pnpm"
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH $PNPM_HOME $PATH
starship init fish | source


# Chromecast options
alias kk="kubectl"
alias tvvolup="catt volumeup 10"
alias tvvoldown="catt volumedown 10"
alias pausetv="catt pause"
alias rewindtv="catt rewind 60"
alias openaf="open -a '/Application/Airflow.app'"
alias tvremote="python3 -m samsungctl --host 192.168.1.37 --method websocket -i"
