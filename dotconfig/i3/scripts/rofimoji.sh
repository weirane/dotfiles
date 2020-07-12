#!/bin/sh

# Choose an emoji from a rofi menu, copy it to the clipboard

emojis=$(realpath "$(dirname "$0")")/emojis

[ ! -f "$emojis" ] && exit

chosen=$(rofi -dmenu -i -no-custom -markup-rows -p "Emoji" < "$emojis")

[ -z "$chosen" ] && exit

printf %s "${chosen%% *}" | xclip -selection clipboard
notify-send 'rofimoji' "'$(xclip -o -selection clipboard)' copied to clipboard."
