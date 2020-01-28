#!/bin/sh
#
# Modified based on:
# https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/openweathermap-detailed/openweathermap-detailed.sh

# Make sure only one instance of this script is running
pgrep -f 'openweathermap-detailed.sh' >/dev/null 2>&1 || exit

API="https://api.openweathermap.org/data/2.5"
KEY=$(<$(dirname `realpath $0`)/owm-key)

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

toggle_simple() {
    kill %% >/dev/null 2>&1
    simple=$(((simple + 1) % 2))
}

update_loc() {
    kill %% >/dev/null 2>&1
    location=''
    get_loc=1
}

prev=''
simple=1
get_loc=1

trap "toggle_simple" USR1
trap "update_loc" USR2

while true; do
    echo "$prev."
    while true; do
        ping api.openweathermap.org -c 1 -W 10 >/dev/null 2>&1 && break
        sleep 60 & >/dev/null 2>&1
        wait
    done

    echo "$prev.."
    if [ "$get_loc" = 1 ]; then
        location=$(curl -sf --retry 3 "https://location.services.mozilla.com/v1/geolocate?key=geoclue")
        get_loc=0
    fi
    echo "$prev..."
    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"
        weather=$(curl -sf --retry 3 "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=metric")
    fi

    if [ -n "$weather" ]; then
        weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
        weather_temp=$(echo "$weather" | jq ".main.temp")
        weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")
        weather_icon="$(get_icon "$weather_icon")"
        city_name=$(echo "$weather" | jq -r ".name")
        if [ "$simple" = 1 ]; then
            prev="$weather_icon $weather_temp°C"
        else
            prev="$weather_icon $weather_desc $weather_temp°C"
        fi
        echo "$prev"
    fi
    sleep 900 & >/dev/null 2>&1
    wait
done
