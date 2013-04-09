#!/bin/bash
#Description: 
#	make vocalbulary agenda
#args:
#	$1: list number
#	$2: word number per list (default 100)
#	-a: append mode
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/4
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin"
cd $path > /dev/null

# default value
declare -i ln=0		#list number
declare -i wpl=100	#word per list
list_name="list"

# argument checking
function Usage()
{
	echo "Usage: eng_agenda_maker.sh [-a] [--name NAME] [--newindex] list_num [words/list]"
	echo -e "\nlist_num : how many word list you gonna have?"
	echo -e "words/list : how many words per list?"
	echo -e "-a : append mode"
	echo -e "--name NAME : customize the list name"
	echo -e "--newindex : the append list's index start from 1"
	echo -e "-an : equal to -a --newindex"
	echo -e "-d : choose another day to plan"
	exit 1
}

if [ $# -eq 0 ]; then 
	Usage
elif [ $# -gt 2 ]; then
	flag_multi_args=true
fi

while [ "$flag_multi_args" == "true" ];do
	case $1 in
		"-a")
			flag_append=true
			shift
			;;
		"--name")
			shift
			list_name=$1
			shift
			;;
		"--newindex")
			flag_newindex=true
			shift
			;;
		"-an")
			flag_append=true
			flag_newindex=true
			shift
			;;
		"-d")
			shift
			flag_nottoday=true
			plan_date=$1
			shift
			;;
		*)
			test_arg=`echo $1$2 | grep '[^0-9]'`
			test -z "$test_arg" && flag_multi_args=false || Usage
			;;
	esac
done

case $# in
	"2")
		wpl=$2
		;;
	*)
		;;
esac
ln=$1

# determine the last date and last list NO
test -e "$USER.eagd" && stat=`head -n 1 $USER.eagd` || touch "$USER.eagd"
if [ "$flag_append" == "true" ] && [ -n "$stat" ]; then
	last_date=`echo $stat | cut -d " " -f1`
	if [ "$flag_newindex" == "true" ]; then
		last_list=0
	else
		last_list=`echo $stat | cut -d " " -f2`
	fi
else
	last_list=$ln
	if [ -n "flag_nottoday" ]; then
		last_date=`date --date="$plan_date" +%Y/%m/%d`
	else
		last_date=`date +%Y/%m/%d`
	fi
fi
list_per_day=$((300/wpl))
if [ $((list_per_day * wpl)) -lt 250 ]; then list_per_day=$((list_per_day+1)); fi
days=$(($ln / list_per_day))
if [ $(( ln % list_per_day )) -gt 0 ]; then days=$(( days + 1 )); fi

#make date records
declare -i i=1
if [ "$flag_append" == "true" ]; then
	for i in $(seq 1 $((days+60)) ); do
		record[$i]=`date --date="$i day $last_date" +%Y/%m/%d`
	done
else
	for i in $(seq 1 $((days+60)) ); do
		record[$i]=`date --date="$i day $last_date" +%Y/%m/%d`
	done
fi

# determine index of the 1st counting NO -- floor
if [ "$flag_append" == "true" ];then
	floor=$((last_list+1))
	last_list=$((last_list+ln))
	last_date=`date --date="$days day $last_date" +%Y/%m/%d`
else
	floor=1
	last_date=`date --date="$days day $last_date" +%Y/%m/%d`
fi

# add context to date record
i=1
for i in $(seq 1 $days); do # i refers to the index of new lists
	# determine the context
	if [ $list_per_day -gt "1" ]; then
		if [ "$((floor+list_per_day))" -gt "$last_list" ]; then
			context="$list_name:$((floor))-$last_list"
		else
			context="$list_name:$((floor))-$((floor+list_per_day-1))"
			floor=$((floor+list_per_day))
		fi
	else
		context="$list_name:$floor"
		floor=$((floor+1))
	fi

	# add context to date record
	irec=$i		# the 1st day
	record[$irec]="${record[irec]} $context"
	irec=$irec+1	# the 2nd day
	record[$irec]="${record[irec]} *$context"
	irec=$irec+2	# the 4th day
	record[$irec]="${record[irec]} *$context"
	irec=$irec+4	# the 8th day
	record[$irec]="${record[irec]} *$context"
	irec=$irec+7	# the 15th day
	record[$irec]="${record[irec]} *$context"
	irec=$irec+15	# the 30th day
	record[$irec]="${record[irec]} *$context"
	irec=$irec+30	# the 60th day
	record[$irec]="${record[irec]} *$context"
done

# write to file
function join_date()
{
	# join file2 to file1 in date, file2's date must later than file1!
	file1=$1; file2=$2
	date_begin=`head -n 2 "$file1" | tail -n 1 | cut -d " " -f1`
	date_end=`tail -n 1 "$file2" | cut -d " " -f1`
	# get file2's header then delete origin header in files
	header=`head -n 1 "$file2"`
	sed -i '1d' "$file1"
	sed -i '1d' "$file2"
	# let's join
	declare -i i=0
	echo -e "\njoining..."
	echo "$header" | tee ".$file1.tmp"
	while [ "$date_now" != "$date_end" ]; do
		date_now=`date --date="$i day $date_begin" +%Y/%m/%d`
		i=$i+1
		content=`cat "$file1" "$file2" | grep "$date_now"`
		content=`echo "$content" | awk '{for(i=2;i<=NF;i++) {printf " " $i}}'`
		echo "$date_now$content" | tee -a ".$file1.tmp"
	done
	mv ".$file1.tmp" "$file1"
}

## header line
if [ "$flag_append" == "true" ]; then
	#create temp file
	echo "make new english agenda..."
	echo "$last_date $last_list" | tee ".$USER.eagdtmp"
	for i in $(seq 1 $((days+60)) ); do
		echo "${record[i]}" | tee -a ".$USER.eagdtmp"
	done
	join_date "$USER.eagd" ".$USER.eagdtmp"
else
	echo "$last_date $last_list" | tee "$USER.eagd"
	for i in $(seq 1 $((days+60)) ); do
		echo "${record[i]}" | tee -a "$USER.eagd"
	done
fi
cp "$USER.eagd" ".$USER.eagd.backup"

cd - > /dev/null
