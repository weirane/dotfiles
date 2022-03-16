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
        flameshot gui
        ;;
    *)
        exit 1
        ;;
esac
