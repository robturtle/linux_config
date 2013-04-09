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

while [ $# -gt 0 ]; do
	case $1 in
		"-d")
			shift
			date_set="$1"
			shift
			;;
		*)
			shift
			;;
	esac
done

if [ -n "$date_set" ]; then
	list=`eng_today_new.sh -a "$date_set"`
	date=`date --date="$date_set" +%Y-%m-%d`
else
	list=`eng_today_new.sh -a`
	date=`date +%Y-%m-%d`
fi

file="$date.words"
echo "$list" | sed 's/\*//g' | sed '/^$/d' | sed 's/$/.words/g' | xargs cat > "$file"
./eng_random.sh "$file"
mv "$file.rnd" "$file"

#read -p "want test now?" ans
case $ans in 
	"y")
		./eng_exam.sh "$file"
		./eng_update.sh "$file" "$file.exm"
		rm "$file.exm"
		;;
	*)
		;;
esac

cd - > /dev/null
