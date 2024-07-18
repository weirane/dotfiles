#!/bin/zsh

export LC_ALL=fr_FR.UTF-8
sketchybar --set $NAME label="$(date '+%a. %e %B %H:%M' | tr A-Z a-z)"
