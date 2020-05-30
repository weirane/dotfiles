#!/bin/sh
width=340
height=193
title='YAD Calendar'

xdotool search --name "^${title}$" && exit 0

LC_ALL=C yad --calendar \
    --name=FloatExec \
    --title="$title" \
    --width=$width --height=$height \
    --no-buttons \
    --close-on-unfocus &
