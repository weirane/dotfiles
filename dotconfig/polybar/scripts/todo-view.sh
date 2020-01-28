#!/bin/sh
todo_file="$HOME/todo.txt"

update() {
    kill %% >/dev/null 2>&1
}

show() {
    termite --class=FloatExec \
            --title="Edit ToDo" \
            --exec "vim -u DEFAULTS $todo_file"
    update
}

trap "show" USR1
trap "update" USR2

while true; do
    # Count the todos. Blank lines and lines begin with "# " are ignored
    num=$(grep -vE '^$|^# ' "$todo_file" -c)
    echo "ToDo ($num)"
    sleep infinity & >/dev/null 2>&1
    wait
done
