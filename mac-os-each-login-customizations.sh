#!/usr/bin/env bash

cd "$(dirname "$0")"

hidutil property --set "$(cat ./macos-hid-properties.json)"
