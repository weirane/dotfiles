#!/bin/sh

# Taken from /usr/share/doc/xss-lock/dim-screen.sh

min_brightness=1
fade_time=200
fade_steps=20

trap 'exit 0' TERM INT

trap "xbacklight -steps 1 -set $(xbacklight -get); kill %%" EXIT

xbacklight -time $fade_time -steps $fade_steps -set $min_brightness

sleep 2147483647 &
wait
