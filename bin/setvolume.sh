#!/bin/bash
# Filename: setvolume.sh
# Author:   LIU Yang
# Create Time: Tue May 28 04:28:19 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

# Parameter: $1 numeric (0-100)

amixer set Master $1%
