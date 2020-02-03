#!/bin/sh

# Terminate already running bar instances
killall --quiet polybar

# Wait until the processes have been shut down
while pgrep --euid "$(id -ru)" --exact polybar >/dev/null; do sleep 1; done

# Launch polybar on all the available monitors
polybar --list-monitors | while read -r line; do
    moni=$(echo "$line" | cut -d':' -f1)
    if echo "$line" | grep 'primary'; then
        MONITOR="$moni" TRAY_POS=right polybar -r top &
    else
        MONITOR="$moni" polybar -r top &
    fi
done
