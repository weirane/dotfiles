#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -U "$(id -ru)" -x polybar >/dev/null; do sleep 1; done

# Launch polybar on all the available monitors
polybar --list-monitors | while read -r line; do
    moni=${line%%:*}
    if expr "$line" : '.*primary' >/dev/null; then
        MONITOR="$moni" TRAY_POS=right polybar -r top &
    else
        MONITOR="$moni" polybar -r top &
    fi
done
