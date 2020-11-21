#!/usr/bin/python3

import atexit
from itertools import chain
from notmuch import Database
import readline as rl
from os import path

PATTERN_PATH = path.join(path.expanduser('~'), '.cache', 'mutt_search')
HIST_PATH = path.join(path.expanduser('~'), '.cache', 'mutt_search_history')
FIELDS = [
    'attachment', 'from', 'mimetype', 'query', 'thread', 'date', 'id',
    'path', 'subject', 'to', 'folder', 'lastmod', 'property', 'tag',
]
OPS = ['and', 'or', 'not', 'xor']

try:
    rl.read_history_file(HIST_PATH)
    hlen = rl.get_current_history_length()
except FileNotFoundError:
    open(HIST_PATH, 'wb').close()
    hlen = 0


def save_hist(prev_h_len, histfile):
    new_hlen = rl.get_current_history_length()
    rl.set_history_length(1000)
    rl.append_history_file(new_hlen - prev_h_len, histfile)


def complete(text, state):
    buf = rl.get_line_buffer()
    candidates = map(lambda x: x + ':', FIELDS)
    if text != buf:
        candidates = chain(candidates, map(lambda x: x + ' ', OPS))
    results = [x for x in candidates if x.startswith(text)] + [None]
    return results[state]


def write_pattern(pat: str):
    with open(PATTERN_PATH, 'w') as f:
        f.write(pat)


atexit.register(save_hist, hlen, HIST_PATH)
rl.parse_and_bind('tab: complete')
rl.set_completer(complete)
write_pattern('')
try:
    term = input('Enter a search term to find with notmuch: ')
except KeyboardInterrupt:
    print()
    exit()

term = term.strip()
db = Database()
pat = '|'.join(m.get_message_id()
               for m in db.create_query(term).search_messages()).replace('+', r'\+')
write_pattern(pat)
