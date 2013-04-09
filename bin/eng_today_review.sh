#!/bin/bash
#Description: 
#	part of english agenda
#	review all of today's assignment
#args:
#	none
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/6
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin/eng_agenda"
cd "$path" > /dev/null

list=`eng_today_new.sh`
file=`echo "$list" | sed 's/$/.words/g'`
./eng_random.sh "$file"
./eng_exam.sh "$file.rnd"
./eng_update.sh "$file" "$file.rnd.exm"
rm "$file.rnd"
rm "$file.rnd.exm"

cd - > /dev/null
