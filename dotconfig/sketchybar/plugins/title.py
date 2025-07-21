#!/usr/bin/env python3

import json
from subprocess import run, PIPE

NARROW_CHARS = 'iIl,.:;!|\'"'
WIDE_CHARS = '—，。、？！：；｜（）【】「」《》'

window = run(['yabai', '-m', 'query', '--windows', '--window'], stdout=PIPE)
if not window.stdout:
    run(['sketchybar', '--set', 'title', 'label=', 'icon='])
    exit(0)
window = json.loads(window.stdout)
title = window['title'] or window['app']
icon = ' '

# Display the position of the window in the stack, if there are multiple windows stacked together
space_windows = run(['yabai', '-m', 'query', '--windows', '--space'], stdout=PIPE)
if space_windows.stdout:
    windows = [
        w
        for w in json.loads(space_windows.stdout)
        if not w.get("is-floating", True) and w.get("is-visible", False) and w.get("stack-index", 0) > 0
    ]

    # Find position of current window in the list
    if len(windows) > 1:
        # Sort by stack-index to get correct stacking order
        windows.sort(key=lambda w: w.get('stack-index', 0))
        position = None
        for i, w in enumerate(windows):
            if w['id'] == window['id']:
                position = i
                break
        if position is not None:
            # Create dot indicator: filled dot for active position, empty dots for others
            icon += ''.join('●' if i == position else '○' for i in range(len(windows)))

# Limit the title length to fit within 60 character length
res = ''
width = 0
for c in title:
    if 0x4e00 <= ord(c) <= 0x9fff or 0x3000 <= ord(c) <= 0x303f or c in WIDE_CHARS:
        width += 2
    elif c in NARROW_CHARS:
        width += 0.7
    elif c.isupper():
        width += 1.2
    else:
        width += 1
    res += c
    if width >= 60:
        res += '…'
        break

run(['sketchybar', '--set', 'title', f'label={res}', f'icon={icon}'])
