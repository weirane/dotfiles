#!/bin/sh
set -e

xset dpms force on
xset dpms 0 5 0
xset +dpms
trap 'xset -dpms' EXIT

i3lock --nofork \
       --color=4c7899 \
       --ignore-empty-password \
       --show-failed-attempts
