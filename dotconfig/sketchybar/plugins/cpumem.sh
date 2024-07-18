#!/bin/zsh

declare -A COLOR
COLOR=(
    [red]=0xffe48fa8 # #e48fa8
    [orange]=0xfff69c5e # #f69c5e
    [yellow]=0xfff5e3b5 # #f5e3b5
    [green]=0xffb3e1a7 # #b3e1a7
)

ncpu=$(sysctl -n machdep.cpu.thread_count)
cpu_info=$(ps -eo pcpu,user)
# cpu_sys=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 != user) sum+=$1 } END {print sum/ncpu}')
# cpu_user=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 == user) sum+=$1 } END {print sum/ncpu}')
cpu_total=$(echo $cpu_info | awk -v ncpu=$ncpu '{ sum += $1 } END {printf("%2d\n", sum / ncpu)}')

mem=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%d\n", 100-$5) }')

case $cpu_total in
    [7-9]?|100) cpu_color=$COLOR[red] ;;
    [4-6]?) cpu_color=$COLOR[orange] ;;
    [2-3]?) cpu_color=$COLOR[yellow] ;;
    *) cpu_color=$COLOR[green] ;;
esac

case $mem in
    9?|100) mem_color=$COLOR[red] ;;
    8?) mem_color=$COLOR[orange] ;;
    6[6-9]|7?) mem_color=$COLOR[yellow] ;;
    *) mem_color=$COLOR[green] ;;
esac

sketchybar --set cpu label=$cpu_total% icon.color=$cpu_color \
           --set mem label=$mem% icon.color=$mem_color
