#!/usr/local/bin/python
# coding=UTF-8

import sys, time, datetime

day = str(time.strftime("%a %H:%M"))

color_teal = '%{$FG[101]%}'
color_reset = '%{$FG[240]%}'

out = color_teal + day + color_reset
sys.stdout.write(out)