#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

EMAIL=$1
PATH=$(realpath $2)

/usr/bin/osascript -e "tell application 'Messages' to send POSIX file '$PATH' to buddy '$EMAIL'"
