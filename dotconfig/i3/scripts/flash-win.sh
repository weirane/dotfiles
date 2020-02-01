#!/bin/sh

# Flash the current focused window

transset-df -a -m 0
sleep .1
transset-df -a -x 1
