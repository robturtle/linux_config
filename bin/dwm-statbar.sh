#!/bin/bash
# Filename: dwm-statbar.sh
# Author:   LIU Yang
# Create Time: Mon May 27 12:10:47 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com

## Battery
bat=$(cat /proc/acpi/battery/BAT0/state)
if echo "$bat" | grep charged &> /dev/null; then
    echo -n " | "
else
    rate=$(echo "$bat" | grep '[0-9]* mA$' | awk '{print $3}')
    capacity=$(echo "$bat" | grep '[0-9]* mAh$' | awk '{print $3}')
    echo -n " | bat: $(($capacity * 60 / $rate)) min | "
fi

## Memory used
mem=$(free -m | grep 'cache:.*' | awk '{print $3}')
echo -n "$mem M | "

## Process count
psc=$(ps -A | wc -l)
echo -n "$psc p | "

## Date
date +'%H:%M %D'
