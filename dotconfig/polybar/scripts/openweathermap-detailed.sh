#!/bin/sh
#
# Modified based on:
# https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/openweathermap-detailed/openweathermap-detailed.sh

weather_file=$HOME/.cache/openweather.json
pid_file=$XDG_RUNTIME_DIR/polybar-openweather.pid
echo $$ >> "$pid_file"
trap "rm -f $pid_file" EXIT

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03*) icon="";;
        04*) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *) icon="";
    esac
    echo $icon
}

update_weather() {
    [ -f "$weather_file" ] || return
    weather=$(cat "$weather_file")
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp")
    weather_temp="$weather_temp°C"
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
    weather_icon="$(get_icon "$weather_icon")"
    city_name=$(echo "$weather" | jq -r ".name")
}

show_weather() {
    [ -n "$weather" ] || return
    case $verbose in
        0) echo "$weather_icon $weather_temp$dot" ;;
        1) echo "$city_name $weather_icon $weather_temp$dot" ;;
        2) echo "$weather_icon $weather_desc $weather_temp$dot" ;;
        *) echo "$city_name $weather_icon $weather_desc $weather_temp$dot" ;;
    esac
}

inc_verbose() {
    verbose=$(((verbose + 1) % 4))
}

verbose=0
dot=

trap "inc_verbose" USR1
trap 'dot=.' RTMIN+1
trap 'dot=..' RTMIN+2
trap 'dot=...' RTMIN+3
trap 'dot=; update_weather' RTMIN+4

sleep infinity &

update_weather
while pgrep -P $$ >/dev/null 2>&1; do
    show_weather
    wait
done
