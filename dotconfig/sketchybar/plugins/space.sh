#!/bin/zsh

spacedata=$(yabai -m query --spaces --space $SID)
nwindows=$(echo $spacedata | jq '.windows | length')
visible=$(echo $spacedata | jq '."is-visible"')

if [[ $visible == true || $nwindows != 0 ]]; then
    drawing=on
else
    drawing=off
fi

sketchybar --set $NAME icon.highlight=$SELECTED background.drawing=$SELECTED drawing=$drawing
