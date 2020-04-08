#!/bin/sh

# Automatically run xmodmap when new input devices is added
#
# Related:
#   https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/287215
#   https://bugs.freedesktop.org/show_bug.cgi?id=25262#c3
#   https://github.com/mgsloan/mgsloan-dotfiles/blob/5efd7be/env/scripts/xmodmap-on-input-change.sh

pgrep -f "inotifywait --quiet --event create --exclude \.\*tmp\.\* /dev/input" && exit

[ ! -f ~/.Xmodmap ] && exit

has_xcape=0
command -v xcape >/dev/null && has_xcape=1

notify-send --expire-time=5000 "xmodmap-on-new-input" "Enabled"

while true; do
    inotifywait --quiet --event create --exclude '.*tmp.*' /dev/input
    sleep 1
    xmodmap ~/.Xmodmap
    [ "$has_xcape" = 1 ] && xcape -e 'Control_L=Escape'
    notify-send --urgency=low --expire-time=2500 "New device" "xmodmap run"
done
