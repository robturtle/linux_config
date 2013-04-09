#!/bin/bash
#Description: 
#	part of english agenda,
#	input words and explain to file
#args:
#	none
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/5
#
#History:
#Special Commands:
#EnvArgs:
path="$HOME/bin/eng_agenda"
cd "$path" > /dev/null

declare -i l2=1		# counter for level 2: 5min 10words
declare -i l3=1		# counter for level 3: 30min 60words
export l2 l3
export l1tmpfile=".$USER.l1tmp"
export l2tmpfile=".$USER.l2tmp"
export l3tmpfile=".$USER.l3tmp"
export list=`eng_today_new.sh`
export file="$list.words"
test -e "$file" && input_file="$file" && input_max=`wc -l "$file" | cut -d " " -f1` 
# level 1: 30s 1word
# level 2: 5min 10words
# level 3: 30min 60words
# level 4: 12h 300words
# level 5: +1d 
# level 6: +2d
# level 7: +4d
# level 8: +7d
# level 9: +15d
# level 10: +30d


# deal with args
while [ $# -gt 0 ]; do
	case $1 in
		"-f")
			shift
			input_file="$1"
			input_max=`wc -l "$input_file" | cut -d " " -f1` 
			shift
			;;
		*)
			shift
			;;
	esac
done

# exam function
function exam()
{
	full_rank=$1
	#read -p "remember rank: " ans
	case $ans in
		"n")
			rank="$full_rank"
			;;
		*)
			echo "$ans" | grep '[^0-9]' > /dev/null && rank="$full_rank" || rank="$ans"
			test -z "$ans" && rank="0"
			;;
	esac
	echo "$rank"
}

# review cycle function
function l1cycle()
{
	# level 1
	record=$1
	word=${record%% *}
	exp=${record#*:}
	exp=${exp%%:*}
	total_rank=${record##*:}

	#rank=`exam "$exp"`
	#test "$rank" -eq "0" && echo "good!" || echo "keep moving..."
	total_rank=$((total_rank+rank))
	echo "$word :$exp:0" >> "$l1tmpfile"
}
function l2cycle()
{
	# level 2
	if [ $l2 -le 9 ]; then
		l2=$l2+1
		echo "$1" >> "$l2tmpfile"
	else
		echo "$1" >> "$l2tmpfile"
		./eng_random.sh "$l2tmpfile"
		./eng_exam.sh "$l2tmpfile.rnd"
		./eng_update.sh "$l3tmpfile" "$l2tmpfile"
		l2=1
		rm "$l2tmpfile" "$l2tmpfile.rnd" "$l2tmpfile.rnd.exm"
		touch "$l2tmpfile"
	fi
}
function l3cycle()
{
	# level 3
	if [ $l3 -le 59 ]; then
		l3=$l3+1
	else
		./eng_random.sh "$l3tmpfile"
		./eng_exam.sh "$l3tmpfile.rnd"
		./eng_update.sh "$file" "$l3tmpfile.rnd.exm"
		l3=1
		rm "$l3tmpfile" "$l3tmpfile.rnd" "$l3tmpfile.rnd.exm"
		touch "$l3tmpfile"
	fi
}

# let's rock
touch "$file"
declare -i iword=`wc -l "$l1tmpfile" | cut -d " " -f1`
declare -i iword2=`wc -l "$l2tmpfile" | cut -d " " -f1`
declare -i iword3=`wc -l "$l3tmpfile" | cut -d " " -f1`
declare -i input_index=1
l2=$iword2+1
l3=$iword3+1
iword=$iword+1
while [ 1 ]; do
	echo
	if [ -e "$input_file" ]; then
		test "$input_index" -le "$input_max" && word=`sed -n "$input_index p" "$input_file"` || word='q'
		input_index=$input_index+1
		echo "$iword word: $word"
		if [ $input_index -eq $input_max ]; then
			iword2=11
			iword3=61
		fi
	else
		read -p "$iword word: " word
	fi

	case $word in
		"q")
			./eng_remind_l4.sh &
			break
			;;
		*)
			if [ -n "$word" ]; then
				read -p "meaning NO: " exp
				#test -z "$exp" && exp=1
				l1cycle "$word :$exp:0" 
				record=`tail -n 1 "$l1tmpfile"`
				l2cycle "$record"
				l3cycle "$record"
				iword=$iword+1
			fi
			;;
	esac
done

cd - > /dev/null
