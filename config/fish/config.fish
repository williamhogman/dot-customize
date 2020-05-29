set fish_greeting
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x  GITHUB_OAUTH_TOKEN 6ce0c288c353c173aa63959f707b507bc1e5114c
set -x PATH "$HOME/.krew/bin:$HOME/.cargo/bin:$PATH"
set pipenv_fish_fancy yes
set -x ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX YES
gpgconf --launch gpg-agent

# Chromecast options
alias tvvolup="catt volumeup 10"
alias tvvoldown="catt volumedown 10"
alias pausetv="catt pause"
alias rewindtv="catt rewind 60"
