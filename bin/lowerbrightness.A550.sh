#!/bin/bash
#change brightness setting on startup or resume
if [ -z "$1" ]; then
    b=0.6
else
    b=$1
fi
xrandr --output LVDS-0 --brightness $b
hdmibrightness.sh $b
