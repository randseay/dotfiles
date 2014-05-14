#!/usr/bin/env python
# coding=UTF-8

import math, subprocess

# Find the AppleSmartBattery

p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0]

# Pull out pertinent key-value pairs

o_max = [l for l in output.splitlines() if 'MaxCapacity' in l][0]
o_cur = [l for l in output.splitlines() if 'CurrentCapacity' in l][0]
o_charge = [l for l in output.splitlines() if 'IsCharging' in l][0]
o_charged = [l for l in output.splitlines() if 'FullyCharged' in l][0]

# Strip out the value in each key-value pair

b_max = float(o_max.rpartition('=')[-1].strip())
b_cur = float(o_cur.rpartition('=')[-1].strip())
b_charge = str(o_charge.rpartition('=')[-1].strip())
b_charged = str(o_charged.rpartition('=')[-1].strip())

charge = b_cur / b_max
charge_threshold = int(math.ceil(10 * charge))

# Output

total_slots, slots = 10, []
filled = int(math.ceil(charge_threshold * (total_slots / 10.0))) * u'▸'
empty = (total_slots - len(filled)) * u'▹'

battery_out = (filled + empty).encode('utf-8')
battery_or_charged = 'Full' if b_charged == 'Yes' else battery_out
charging_out = ' ⚡︎' if b_charge == 'Yes' else ''
import sys

color_gold = '%{$FG[214]%}'
color_green = '%{$FG[034]%}'
color_yellow = '%{$FG[184]%}'
color_red = '%{$FG[160]%}'
color_reset = '%{$FG[240]%}'
color_out = (
    color_green if len(filled) > 6
    else color_yellow if len(filled) > 4
    else color_red
)

out = color_out + battery_or_charged + color_gold + charging_out + color_reset
sys.stdout.write(out)