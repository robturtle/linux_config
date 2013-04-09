#!/bin/bash
#Description: 
#	service of english agenda
#	give a random words to u
#args:
#	none
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/9
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin/eng_agenda"
cd "$path" > /dev/null

date_now=`date +%Y-%m-%d`
file="$date_now.words"
row_num=`wc -l "$file" | cut -d " " -f1`
rand_index=$(( 1 + row_num * RANDOM / 32768 ))
word=`cat "$file" | cut -d " " -f1 | sed -n "$rand_index p"`

echo "$word"
export DISPLAY=:0.0
gnome-osd-client "$word"

cd - > /dev/null
