#!/bin/zsh

visible=$(yabai -m query --spaces --space $SID | jq '."is-visible"')
nwindows=$(yabai -m query --windows | jq "map(select(.\"is-sticky\"==false and .scratchpad!=\"dropdownterm\" and .space==$SID)) | length")

if [[ $visible == true || $nwindows != 0 ]]; then
    drawing=on
else
    drawing=off
fi

sketchybar --set $NAME icon.highlight=$SELECTED background.drawing=$SELECTED drawing=$drawing
