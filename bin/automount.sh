#!/bin/bash
#Description: This script mount the device at /media/$LABEL
#args:
#	$1 the base name of device, if $1 is a pathname, script will convert it to basename
#Author: LiuYang
#ContectMe: JeremyRobturtle@gmail.com
#LastModified: 2012/7/29
if [ -z $1 ]; then
	echo "You must specify a device's name at the following argument."
	exit 127
else
	device_name=${1##*/}			#stretch the basename of device
	str1=`blkid | grep $1`			#find message of the device
	if [ -z $str1]; then
		echo "Special device not found"
		exit 255
	else
		str1=${str1#*\"}
		label=${str1%%\"*}		#stretch the label between 1st ""
		echo "mounting /dev/$1 to /media/$label..."
		test -e /media/$label && mkdir /media/$label
		mount /dev/$device_name /media/$label
	fi
fi
exit 0
