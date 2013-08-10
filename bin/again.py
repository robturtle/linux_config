#!/usr/bin/env python
# Filename: again.sh
# Author:   LIU Yang
# Create Time: Mon May  6 23:59:06 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
"""Use this to do the last shell command again"""
import sys
import os

cmd = ' '.join(sys.argv[1:])

lastcmd_file = '/home/jeremy/bin/.again'
if cmd:
    with open(lastcmd_file, 'w') as f:
        f.write(cmd)
    print cmd
else:
    with open(lastcmd_file) as f:
        cmd = f.read()
    print cmd
