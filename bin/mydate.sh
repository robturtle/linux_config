#!/bin/bash
#Description: 
#	count how many days from now and tell u today's english assignment
#args:
#	$1: days after
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/7/29
#
#History:
#Special Commands:
#EnvArgs:

#read -p "input counting date (e.g. 20120729): " final_date
#date_ck=`echo $final_date | grep '[0-9]\{8\}'`		#check input
#[ -z date_ck ] && echo "Wrong date format!" && exit 1

final_date=20121028

# deal with args
while [ $# -gt 0 ]; do
	case $1 in
		*)
			days=$1
			shift
			;;
	esac
done

declare -i date_final=`date --date="$final_date" +%s`
declare -i date_now=`date +%s`
declare -i day_diff=($date_final-$date_now)/60/60/24
if [ "$day_diff" -lt "0" ]; then
	msg="The date is $((-1*day_diff)) ago"
else
	declare -i h_mod=($date_final-$date_now)/60/60%24
	msg="$day_diff d and $h_mod h left"
fi
tw=`eng_today_new.sh -a $days`
echo "$msg"
echo "$tw"
export DISPLAY=:0.0
notify-send -t 10000 "$msg" "$tw"
