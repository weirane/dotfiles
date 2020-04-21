#!/bin/sh

# Script for the todos module on my polybar. The total number of todos and the
# number of todos that due today are shown.

todo_file="$HOME/todo.txt"
pid_file="$HOME/.config/polybar/scripts/.todo.pid"

echo "$$" > "$pid_file"
trap "rm -f $pid_file" EXIT

update() {
    pkill --parent $$ -x sleep >/dev/null
}

show() {
    xdotool search --class 'Alacritty' \
            search --name 'Edit Todo' >/dev/null && return
    alacritty --class=FloatExec \
              --title="Edit ToDo" \
              -e nvim -u NONE -c 'set laststatus=0' "$todo_file"
    update
}

trap "show &" USR1
trap "update" USR2

while true; do
    # Get the todos. Blank lines and lines begin with "# " are ignored
    todos=$(grep -vE '^$|^# ' "$todo_file")
    num=$(echo "$todos" | wc -l)
    today=$(echo "$todos" | grep "($(date +%m-%d))$" -c)
    if [ "$today" -gt 0 ]; then
        today=", $today"
    else
        today=""
    fi
    echo "ToDo ($num$today)"
    sleep 2h >/dev/null 2>&1 &
    while pgrep --parent $$ -x sleep >/dev/null; do
        wait
    done
done
