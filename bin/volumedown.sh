#!/bin/bash
# Filename: volumedown.sh
# Author:   LIU Yang
# Create Time: Tue May 28 05:00:04 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

[ "$1" == "" ] && delta=10 || delta=$1
vol=$(getvolume.sh)
vol=${vol::-1}
vol=$(($vol - $delta))
[ $vol -lt 0 ] && vol=0
setvolume.sh $vol
echo $vol
