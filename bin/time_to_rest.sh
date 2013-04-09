#!/bin/bash
#Description: 
#	tell u time to rest
#args:
#	$1: work time
#	$2: rest time
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/4
#
#History:
#Special Commands:
#EnvArgs:

# input argument
declare -i t_sleep=3300
declare -i t_rest=300
declare -i t_rest_bk=300
if [ $# -gt 0 ];then
	t_sleep=$1
	shift
	if [ $# -gt 0 ]; then
		t_rest=$1
		t_rest_bk=$t_rest
	fi
fi

# exec
sleep $t_sleep
while [ 1 ]; do
	export DISPLAY=:0.0
	notify-send "Rest!" "It's time to rest your eyes!"
	while [ $t_rest -gt 0 ]; do 
		export DISPLAY=:0.0
		gnome-osd-client "rest time: $t_rest"
		t_rest=$t_rest-1
		sleep 1
	done
	export DISPLAY=:0.0
	notify-send "Work" "Go back to work, sir~"
	export DISPLAY=:0.0
	gnome-osd-client "Roll back to work!"
	t_rest=$t_rest_bk
	sleep $t_sleep
done
