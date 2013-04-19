#!/bin/zsh

c_on_a_mac() {
    local OS=$(uname)
    local MAC="Darwin"
    if [[ $OS = $MAC ]]; then
        echo 1
        return 1
    else
        return 0
        echo 0
    fi
}
