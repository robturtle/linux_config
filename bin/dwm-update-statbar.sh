#!/bin/bash
# Filename: dwm-update-statbar.sh
# Author:   LIU Yang
# Create Time: Tue May 28 04:34:27 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

VOL=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
LOCALTIME=$(date +'%H:%M %D')
IP=$(for i in $(ip r); do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

if acpi -a | grep off-line > /dev/null
then
    BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
    xsetroot -name "$IP | $BAT | $VOL | $TEMP | $LOCALTIME "
else
    xsetroot -name "$IP | $VOL | $TEMP | $LOCALTIME"
fi
