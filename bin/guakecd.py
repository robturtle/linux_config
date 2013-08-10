#!/usr/bin/env python
# Filename: guakecd.py
# Author:   LIU Yang
# Create Time: Tue May  7 23:32:08 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

from sys import argv
import os

try:
    times = int(argv[1])
except (IndexError, ValueError):
    times = 1

try:
    directory = argv[2]
except IndexError:
    directory = os.getcwd()

try:
    tagname = argv[3]
except:
    tagname = 'hehe' # TODO: read from clipboard

# get current tag's name
os.system('xdotool key F2')
os.system('xdotool key Ctrl+c Escape')

for i in range(times):
    os.system('xdotool key ctrl+shift+t') # Open another Guake tag
    os.system('xdotool type "cd '+directory+'"')
    os.system('xdotool key Return')
    """ Change tag's name """
    os.system('xdotool key F2 Ctrl+v')
    os.system('xdotool type " '+str(i+2)+'"')
    os.system('xdotool key Return')
