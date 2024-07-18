#!/bin/zsh

if [[ $SENDER == "skhd_mode_change" ]]; then
    case $MODE in
        default) sketchybar --set $NAME label.drawing=off ;;
        move)    sketchybar --set $NAME label.drawing=on label='[M]' ;;
        resize)  sketchybar --set $NAME label.drawing=on label='[R]' ;;
    esac
fi
