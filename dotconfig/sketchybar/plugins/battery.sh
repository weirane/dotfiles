#!/bin/zsh

declare -A COLOR
COLOR=(
    [fg]=0xffeceff4 # #eceff4
    [bg]=0xff1e1d2e # #1e1d2e
    [bg_selected]=0xff3c3e4f # #3c3e4f
    [blue]=0xff92b3f5 # #92b3f5
    [red]=0xffe48fa8 # #e48fa8
    [orange]=0xfff69c5e # #f69c5e
    [yellow]=0xfff5e3b5 # #f5e3b5
    [green]=0xffb3e1a7 # #b3e1a7
)

bstatus="$(pmset -g batt)"
percentage="$(echo $bstatus | grep -Eo "\d+%" | cut -d% -f1)"
charging="$(echo $bstatus | grep 'AC Power')"

if [[ -z $percentage ]]; then
    exit 0
fi

color=$COLOR[green]
if [[ -z $charging ]]; then
    case $percentage in
        9[7-9]|100) icon=󰁹 ;;
        9?) icon=󰂂 ;;
        8?) icon=󰂁 ;;
        7?) icon=󰂀 ;;
        6?) icon=󰁿 ;;
        5?) icon=󰁾 ;;
        4?) icon=󰁽 ;;
        3?) icon=󰁼 ;;
        2?) icon=󰁻 ;;
        1?) icon=󰁺; color=$COLOR[yellow] ;;
        *) icon=󰂎; color=$COLOR[red] ;;
    esac
else
    case $percentage in
        9[7-9]|100) icon=󰂅 ;;
        9?) icon=󰂋 ;;
        8?) icon=󰂊 ;;
        7?) icon=󰢞 ;;
        6?) icon=󰂉 ;;
        5?) icon=󰢝 ;;
        4?) icon=󰂈 ;;
        3?) icon=󰂇 ;;
        2?) icon=󰂆 ;;
        1?) icon=󰢜 ;;
        *) icon=󰢟 ;;
    esac
fi

# label="$percentage%"

sketchybar --set $NAME icon=$icon icon.color=$color
