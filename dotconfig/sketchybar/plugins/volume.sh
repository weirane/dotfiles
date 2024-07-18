#!/bin/zsh

if [[ $SENDER == volume_change ]]; then
    volume=$INFO

    if (( volume >= 60 )); then
        sketchybar --set $NAME icon=󰕾 icon.padding_right=2 label=$volume%
    elif (( volume >= 20 )); then
        sketchybar --set $NAME icon=󰖀 icon.padding_right=3 label=$volume%
    elif (( volume >= 1 )); then
        sketchybar --set $NAME icon=󰕿 icon.padding_right=4 label=$volume%
    else
        sketchybar --set $NAME icon=󰖁 icon.padding_right=2 label=$volume%
    fi
fi
