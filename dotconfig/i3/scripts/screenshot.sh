#!/bin/sh

# Screenshot script for i3

base="Screenshot-$(date +%F_%T).png"
default="$HOME/Pictures/$base"

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
        save=$(zenity --title 'Save the screenshot' \
               --file-selection --save \
               --filename="$base" \
               --confirm-overwrite)
        if [ $? = 1 ] || [ -z "$save" ]; then
            xclip-cutfile "$full_fn"
            notify 'Use xclip-pastfile to get the screenshot'
        else
            mv -f "$full_fn" "$save" &&
                notify "Screenshot saved as $save"
        fi
        ;;
    *)
        exit 1
        ;;
esac
