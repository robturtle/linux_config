#!/bin/bash
#Description: 
#	part of english agenda,
#	tell what's today's new
#args:
#	$1: date
#	-n: new assignment
#	-r: review assignment
#	-a: -n -r
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/5
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin"
cd "$path" > /dev/null

#default settings
flag_new=true
unset flag_review

# deal with args
while [ $# -gt 0 ]; do
	case $1 in
		"-n")
			flag_new=true
			unset flag_review
			shift
			;;
		"-r")
			flag_review=true
			unset flag_new
			shift
			;;
		"-a")
			flag_new=true
			flag_review=true
			shift
			;;
		*)
			days="$1"
			shift
			;;
	esac
done

if [ -n "$days" ]; then
	date_tran=`date --date="$days" +%Y-%m-%d`
	eng_agenda/eng_today_words.sh "$days"
else
	date_tran=`date +%Y-%m-%d`
	eng_agenda/eng_today_words.sh
fi
file=".$USER.$date_tran.eagd"
todaymsg=`test -e "$file" && cat "$file" | awk '{for(i=2;i<=NF;i++) {print $i}}' | grep -v '[*]'`
reviewmsg=`test -e "$file" && cat "$file" | awk '{for(i=2;i<=NF;i++) {print $i}}' | grep '[*]'`

test -n "$flag_new" && msg="$msg$todaymsg"
test -n "$flag_review" && test -n "$reviewmsg" && msg="$msg\n$reviewmsg"
test -n "$msg" && echo -e "$msg" || echo "You have no assignment today!"
#test -n "$msg" && notify-send "Today's work:" "$msg" 

cd - > /dev/null
