#!/usr/bin/env python3
# coding=UTF-8

import getpass, os, sys
from sys import argv

script, wd_max_width = argv

wd_full = os.getcwd().replace("/Users/" + getpass.getuser(),"~")
wd_list = wd_full.split("/")

if len(wd_full) > int(wd_max_width):
    for i in range(1,len(wd_list)-1):
        wd_list[i] = wd_list[i][:1]
        wd_path = '/'.join(str(x) for x in wd_list)
        if len(wd_path) < int(wd_max_width):
            break
    out = '/'.join(str(x) for x in wd_list)
else:
    out = wd_full

sys.stdout.write(out)
