# Filename: linuxconfig_backup.sh
# Author:   LIU Yang
# Create Time: Sun Dec 22 18:01:47 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Mv the real file into ~/git/linux_config and make a soft link 
#        in original place
[[ -z "$1" ]] && echo "USAGE: $0 filename" && exit 1

mv "$1" git/linux_config
ln -s git/linux_config/"$1" .
