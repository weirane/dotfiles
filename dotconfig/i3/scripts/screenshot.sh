#!/bin/sh

# Screenshot script for i3

base="Screenshot-$(date +%F_%T).png"
default="$HOME/Pictures/$base"

last_path=$(cat "${XDG_CACHE_HOME:-$HOME/.cache}/screenshot-path" 2>/dev/null)
[ -d "$last_path" ] || last_path=$HOME

notify() {
    notify-send --expire-time=1500 "Screenshot" "$1"
}

case "$1" in
    -p | --whole) # Whole screen
        scrot "$default"
        notify "Screenshot saved as $default"
        ;;
    -w | --window) # Current window
        scrot -u "$default"
        notify "Screenshot of the current window saved as $default"
        ;;
    -s | --select) # Selection
        full_fn="/tmp/$base"
        scrot -s "$full_fn" || {
            notify 'Abort'
            exit
        }
        save=$(yad --title 'Save the screenshot' \
               --width=1230 --height=750 \
               --file --save \
               --filename="$last_path/$base" \
               --confirm-overwrite)
        if [ $? = 1 ] || [ -z "$save" ]; then
            xclip-cutfile "$full_fn"
            notify 'Use xclip-pastfile to get the screenshot'
        else
            mv -f "$full_fn" "$save" &&
                notify "Screenshot saved as $save" &&
                (realpath "$(dirname "$save")" > "$HOME/.cache/screenshot-path")
        fi
        ;;
    *)
        exit 1
        ;;
esac
