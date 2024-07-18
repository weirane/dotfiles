#!/bin/zsh

NI=en0

wifi_is_on() {
    networksetup -getairportpower $NI | grep -q "On"
}

speed_with_unit() {
    local speed=$1
    local unit
    if (( speed > 1024*1024 )); then
        speed=$((speed / (1024*1024)))
        unit='G'
    elif (( speed > 1024 )); then
        speed=$((speed / 1024))
        unit='M'
    else
        unit='K'
    fi
    printf "%d %s\n" $speed $unit
}

get_wifi_speed() {
    (! wifi_is_on) && echo 'N/A' && return 0

    local speeds=($(ifstat -i $NI 0.1 1 | awk 'NR==3 {print $1,$2}'))
    local up=$(speed_with_unit ${speeds[2]})
    local down=$(speed_with_unit ${speeds[1]})

    echo "⬆$up ⬇$down"
}

update_wifi_speed() {
    sketchybar --set $NAME label="$(get_wifi_speed)"
}

update_wifi_status() {
    if wifi_is_on; then
        sketchybar --set $NAME update_freq=3 icon=󰤨 label.drawing=on label="$(get_wifi_speed)"
    else
        sketchybar --set $NAME update_freq=0 icon=󰤮 label.drawing=off
    fi
}

case $SENDER in
    routine) update_wifi_speed ;;
    wifi_change) update_wifi_status ;;
esac
