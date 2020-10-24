set fish_greeting
set -x GPG_TTY (tty)
set -x PATH "/usr/local/MacGPG2/bin:/usr/local/bin:$HOME/.bin/:$HOME/.krew/bin:$HOME/.cargo/bin:$HOME/.go/bin:$PATH"
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set pipenv_fish_fancy yes
set -x ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES
set -x VISUAL "emacsclient -a nano -q"
gpgconf --launch gpg-agent

# Chromecast options
alias tvvolup="catt volumeup 10"
alias tvvoldown="catt volumedown 10"
alias pausetv="catt pause"
alias rewindtv="catt rewind 60"
alias openaf="open -a '/Application/Airflow.app'"
alias tvremote="python3 -m samsungctl --host 192.168.1.37 --method websocket -i"
