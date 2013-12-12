# Filename: hdmibrightness.sh
# Author:   LIU Yang
# Create Time: Wed Dec 11 04:40:37 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Set brightness of HDMI monitor
if [ -z "$1" ]; then
    $1="0.4"
fi

xrandr --output HDMI-0 --brightness $1
