#!/bin/bash
xset +fp /usr/share/fonts/X11/
xset fp rehash

## ssh
eval $(/usr/bin/ssh-agent)

if test -f /usr/lib/openssh/x11-ssh-askpass # Archlinux
then
    SSH_ASKPASS=/usr/lib/openssh/x11-ssh-askpass ssh-add < /dev/null
fi

if test -f /usr/lib/ssh/x11-ssh-askpass # Debian
then
    SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass ssh-add < /dev/null
fi

## Key layout
setxkbmap -option 'ctrl:nocaps'
## Brightness
lowerbrightness.sh

# Showing status
while true; do
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
    sleep 20s
done &

# Hot restart
while true; do
    # Log stderr to a file
    dwm 2> ${HOME}/.dwm.log
    # No error logging
    # dwm > /dev/null 2>&1
done
