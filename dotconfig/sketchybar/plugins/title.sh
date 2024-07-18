#!/bin/zsh

windowinfo=$(yabai -m query --windows --window)

title=$(echo $windowinfo | jq -r '.title')
if [[ -z $title ]]; then
    title=$(echo $windowinfo | jq -r '.app')
fi

res=''
width=0
for i in {1..${#title}}; do
    unicode=$(printf %d \'$title[$i])
    if (( unicode >= 0x4e00 && unicode <= 0x9fff )); then
        let width+=2
    else
        let width+=1
    fi
    res+=$title[$i]
    if (( width >= 60 )); then
        res+=…
        break
    fi
done

sketchybar --set title label=$res
