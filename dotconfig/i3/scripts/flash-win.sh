#!/bin/sh

# Flash the current focused window

set -e
picom-trans -c 75
trap 'picom-trans -c 100' EXIT
sleep 0.005
