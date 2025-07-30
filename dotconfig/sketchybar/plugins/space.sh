#!/bin/zsh

# Handle scroll events for space navigation
if [[ -n "$SCROLL_DELTA" ]]; then
    # Get the display ID for the current space
    display_id=$(yabai -m query --spaces --space $SID | jq '.display')
    if [[ $SCROLL_DELTA -gt 2 ]]; then
        # Scroll up - go to previous space
        yabai3.py focus space.prev $display_id
    elif [[ $SCROLL_DELTA -lt -2 ]]; then
        # Scroll down - go to next space
        yabai3.py focus space.next $display_id
    fi
    exit 0
fi

visible=$(yabai -m query --spaces --space $SID | jq '."is-visible"')
nwindows=$(yabai -m query --windows | jq "map(select(.\"is-sticky\"==false and .scratchpad!=\"dropdownterm\" and .space==$SID)) | length")

if [[ $visible == true || $nwindows != 0 ]]; then
    drawing=on
else
    drawing=off
fi

sketchybar --set $NAME icon.highlight=$SELECTED background.drawing=$SELECTED drawing=$drawing
