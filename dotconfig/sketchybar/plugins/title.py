#!/usr/bin/env python3

import json
from subprocess import run, PIPE

NARROW_CHARS = 'iIl,.:;!|\'"'
WIDE_CHARS = '—，。、？！：；｜（）【】「」《》'

window = run(['yabai', '-m', 'query', '--windows', '--window'], stdout=PIPE)
if not window.stdout:
    run(['sketchybar', '--set', 'title', 'label='])
    exit(0)
window = json.loads(window.stdout)
title = window['title'] or window['app']

res = ''
width = 0
for c in title:
    if 0x4e00 <= ord(c) <= 0x9fff or 0x3000 <= ord(c) <= 0x303f or c in WIDE_CHARS:
        width += 2
    elif c in NARROW_CHARS:
        width += 0.7
    else:
        width += 1
    res += c
    if width >= 60:
        res += '…'
        break

run(['sketchybar', '--set', 'title', f'label={res}'])
