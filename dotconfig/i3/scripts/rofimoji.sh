#!/bin/sh

# Choose an emoji from a rofi menu, copy it to the clipboard

# Must have xclip installed to even show menu.
command -v xclip >/dev/null || exit

emojis=$(realpath "$(dirname "$0")")/emojis

[ ! -f "$emojis" ] && exit

chosen=$(rofi -dmenu -i -no-custom -markup-rows -p "Emoji" < "$emojis")

[ -z "$chosen" ] && exit

echo "$chosen" | awk '{ printf "%s",$1 }' | xclip -selection clipboard
notify-send 'rofimoji' "'$(xclip -o -selection clipboard)' copied to clipboard."
