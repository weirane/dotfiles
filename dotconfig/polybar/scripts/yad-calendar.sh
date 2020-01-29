#!/bin/sh
width=340
height=193
title='YAD Calendar'

if xdotool search --name "^${title}$"; then
    exit 0
fi

export LC_ALL=C

setsid --fork yad --calendar \
    --class=FloatExec \
    --title="$title" \
    --width=$width --height=$height \
    --no-buttons \
    --close-on-unfocus
