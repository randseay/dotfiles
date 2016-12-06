#!/usr/bin/env python
# coding=UTF-8

import math, subprocess, sys

divisor = 6

# Find the AppleSmartBattery

p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
output = p.communicate()[0]

if len(output):
    # Pull out pertinent key-value pairs

    o_max = [l for l in output.splitlines() if b'MaxCapacity' in l][0]
    o_cur = [l for l in output.splitlines() if b'CurrentCapacity' in l][0]
    o_charge = [l for l in output.splitlines() if b'IsCharging' in l][0]
    o_charged = [l for l in output.splitlines() if b'FullyCharged' in l][0]
    o_time_remaining = [l for l in output.splitlines() if b'TimeRemaining' in l][0]

    # Strip out the value in each key-value pair

    b_max = float(o_max.rpartition(b'=')[-1].strip())
    b_cur = float(o_cur.rpartition(b'=')[-1].strip())
    b_charge = str(o_charge.rpartition(b'=')[-1].strip())
    b_charged = str(o_charged.rpartition(b'=')[-1].strip())
    b_time_remaining = int(o_time_remaining.rpartition(b'=')[-1].strip())

    charge = b_cur / b_max
    charge_threshold = int(math.ceil(divisor * charge))
    time_remaining = str(b_time_remaining / 60) + ':' + str(b_time_remaining % 60).zfill(2)

    # Output

    total_slots, slots = divisor, []
    filled = int(math.ceil(charge_threshold * (total_slots / float(divisor)))) * u'▸'
    empty = (total_slots - len(filled)) * u'▹'

    battery_out = b' ' + (filled + empty).encode('utf-8')
    battery_or_charge = (
        b' Full' if b_charged == b'Yes'
        else '' if b_charge == b'Yes'
        else battery_out
    )
    charging_out = u' ⚡︎' if b_charge == b'Yes' else b''
    time_remaining = b' [' + time_remaining + b']' if b_charged == b'No' else b''

    color_gold = b'%{$FG[214]%}'
    color_green = b'%{$FG[034]%}'
    color_yellow = b'%{$FG[184]%}'
    color_red = b'%{$FG[160]%}'
    color_reset = b'%{$FG[240]%}'
    color_out = (
        color_green if len(filled) > int(math.ceil(divisor * 2 / 3))
        else color_yellow if len(filled) > int(math.ceil(divisor / 3))
        else color_red
    )
    out = color_out + battery_or_charge + color_gold + charging_out + color_reset + time_remaining
    sys.stdout.write(out.decode('utf-8'))
