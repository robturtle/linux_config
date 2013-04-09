#!/bin/bash
#Description: 
#	cycle execute a program
#args:
#	$1: program
#	-t: sleeping time in seconds (default is 1)
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/4
#
#History:
#Special Commands:
#EnvArgs:

#usage:
function usage()
{
	echo "cycle.sh usage:"
	echo "cycle.sh [-w TIME] [-t TIME] PROGRAM"
	exit 1
}

declare -i t_sleep=1
# deal with arguments
if [ $# -eq 0 ]; then
	usage
fi

while [ $# -gt 0 ]; do 
	case $1 in
		"-w")
			if [ $# -lt 3 ]; then
				usage
			fi
			t_wait=$2
			shift 2
			;;
		"-t")
			if [ $# -lt 3 ]; then
				usage
			fi
			t_sleep=$2
			shift 2
			;;
		*)
			app=$1
			shift
			;;
	esac
done

# execute
sleep $t_wait
while [ 1 ]; do
	$app
	sleep $t_sleep
done
