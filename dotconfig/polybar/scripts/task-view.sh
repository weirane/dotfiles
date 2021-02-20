#!/bin/sh

pid_file="$XDG_RUNTIME_DIR/polybar-task.pid"

echo "$$" > "$pid_file"
trap "rm -f $pid_file" EXIT

update() {
    pkill -P $$ -x sleep >/dev/null
}

show() {
    xdotool search --class 'Alacritty' \
            search --name 'Edit Task' >/dev/null && return
    TASKMODE=1 alacritty --class=FloatExec --title="Edit Task"
    update
}

trap "show &" USR1
trap "update" USR2

while [ "$(cut -d '' -f1 /proc/$PPID/cmdline)" = polybar ]; do
    num=$(task +PENDING count)
    today=$(task +PENDING 'due <= tomorrow' count)
    overdue=$(task +OVERDUE count)
    today_num=""
    overdue_num=""
    [ "$today" -gt 0 ] && today_num=", $today"
    [ "$overdue" -gt 0 ] && overdue_num=", !$overdue"
    echo "Task ($num$today_num$overdue_num)"
    sleep 2h &
    while pgrep -P $$ -x sleep >/dev/null; do wait; done
done
