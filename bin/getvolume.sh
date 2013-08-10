#!/bin/bash
# Filename: getvolume.sh
# Author:   LIU Yang
# Create Time: Tue May 28 04:49:50 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
echo $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
