#!/usr/bin/env python3
# coding=UTF-8

import math, subprocess, sys

def extract_float(line):
    value = line.rpartition(b'=')[-1].strip()
    # Remove trailing non-digit characters (e.g., '}')
    value = value.rstrip(b'}')
    return float(value)

def extract_int(line):
    value = line.rpartition(b'=')[-1].strip()
    value = value.rstrip(b'}')
    return int(value)

def extract_str(line):
    return line.rpartition(b'=')[-1].strip()

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

    b_max = extract_float(o_max)
    b_cur = extract_float(o_cur)
    b_charge = extract_str(o_charge)
    b_charged = extract_str(o_charged)
    b_time_remaining = extract_int(o_time_remaining)

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
