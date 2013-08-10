#!/bin/bash
# Filename: volumeup.sh
# Author:   LIU Yang
# Create Time: Tue May 28 04:54:15 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

[ "$1" == "" ] && delta=10 || delta=$1
vol=$(getvolume.sh)
vol=${vol::-1}
vol=$(($vol + $delta))
[ $vol -gt 100 ] && vol=100
setvolume.sh $vol
echo $vol
