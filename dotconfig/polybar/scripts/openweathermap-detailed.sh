#!/bin/sh
#
# Modified based on:
# https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/openweathermap-detailed/openweathermap-detailed.sh

# Make sure only one instance of this script is running
pgrep -f 'openweathermap-detailed.sh' >/dev/null 2>&1 || exit

API="https://api.openweathermap.org/data/2.5"
KEY=$(cat $(dirname `realpath $0`)/owm-key)

if [ -z "$KEY" ]; then
    echo "No key"
    sleep infinity
fi

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

show_weather() {
    case $verbose in
        0)
            echo "$weather_icon $weather_temp$dot"
            ;;
        1)
            echo "$city_name $weather_icon $weather_temp$dot"
            ;;
        2)
            echo "$weather_icon $weather_desc $weather_temp$dot"
            ;;
        *)
            echo "$city_name $weather_icon $weather_desc $weather_temp$dot"
            ;;
    esac
}

inc_verbose() {
    verbose=$(((verbose + 1) % 4))
    show_weather
}

update_loc() {
    location=''
    get_loc=1
    kill %% >/dev/null 2>&1
}

verbose=0
get_loc=1

trap "inc_verbose" USR1
trap "update_loc" USR2

while true; do
    dot="."
    show_weather
    while true; do
        ping api.openweathermap.org -c 1 -W 10 >/dev/null 2>&1 && break
        sleep 60 & >/dev/null 2>&1
        while kill -0 %% >/dev/null 2>&1; do
            wait
        done
    done

    dot=".."
    show_weather
    if [ "$get_loc" = 1 ]; then
        location=$(curl -sf --retry 3 "https://location.services.mozilla.com/v1/geolocate?key=geoclue")
        get_loc=0
    fi
    dot="..."
    show_weather
    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"
        weather=$(curl -sf --retry 3 "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=metric")
    fi

    if [ -n "$weather" ]; then
        weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
        weather_temp=$(echo "$weather" | jq ".main.temp")
        weather_temp="$weather_temp°C"
        weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
        weather_icon="$(get_icon "$weather_icon")"
        city_name=$(echo "$weather" | jq -r ".name")
        dot=''
        show_weather
    fi
    sleep 900 & >/dev/null 2>&1
    while kill -0 %% >/dev/null 2>&1; do
        wait
    done
done
