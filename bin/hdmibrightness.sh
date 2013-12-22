# Filename: hdmibrightness.sh
# Author:   LIU Yang
# Create Time: Wed Dec 11 04:40:37 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Set brightness of HDMI monitor
if [ -z "$1" ]; then
    b="0.4"
else
    b=$1
fi

xrandr --output HDMI-0 --brightness $b
