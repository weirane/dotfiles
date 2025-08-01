#!/usr/bin/env python3

import json
import sys
import os
from subprocess import run, PIPE


# If SCROLL_DELTA is set, handle scroll events to focus previous/next window in stack
if scroll_delta := os.environ.get('SCROLL_DELTA'):
    try:
        delta = int(scroll_delta)
        if abs(delta) > 2:
            run(['yabai3', 'focus', 'stack.prev' if delta > 0 else 'stack.next'])
    except ValueError:
        # If SCROLL_DELTA is not a valid integer, ignore it
        sys.exit(0)


def json_run(args):
    '''Run command and return json output'''
    shell = isinstance(args, str)
    r = run(args, stdout=PIPE, shell=shell)
    return json.loads(r.stdout) if r.stdout else {}


NARROW_CHARS = 'iIl,.:;!|\'"'
WIDE_CHARS = '—，。、？！：；｜（）【】「」《》'
SEP = ' '
window = json_run(['yabai', '-m', 'query', '--windows', '--window'])


# Title of the application, shortened to fit within 60 characters
title = window.get('title') or window.get('app') or ''
shortened_title = ''
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
    shortened_title += c
    if width >= 60:
        shortened_title += '…'
        break


# Window state icon
if window.get('is-floating', False):
    # If window is floating, show a floating icon
    window_state = '󰖲'
elif (space := json_run(['yabai', '-m', 'query', '--spaces', '--space'])) and space.get('type') == 'stack':
    # If space is a stack, show the stack as dots
    windows = [
        w
        for w in (json_run(['yabai', '-m', 'query', '--windows', '--space']) or [])
        if not w.get("is-floating", True) and w.get("is-visible", False) and w.get("stack-index", 0) > 0
    ]
    if len(windows) > 1:
        position = window.get('stack-index')
        # Create dot indicator: filled dot for active position, empty dots for others
        window_state = ''.join('●' if i == position else '○' for i in range(1, 1 + len(windows)))
    else:
        # If only one window in stack, just show a single dot
        window_state = '●'
else:
    # If space is bsp, show a window icon
    window_state = '󰕰'


# Set the title and icon in SketchyBar
run(['sketchybar', '--set', 'title', f'label={shortened_title}', f'icon={SEP}{window_state}'])
