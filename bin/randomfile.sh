#!/bin/bash
#Description: 
#	part of english agenda
#	randomize the word list
#args:
#	$*: input file
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/6
#
#History:
#Special Commands:
#EnvArgs:

#path="$HOME/bin/eng_agenda"
#cd $path > /dev/null

tmpfile=".$USER.rndtmp"
file="$1.rnd"

if [ $# -gt 0 ]; then
	touch "$tmpfile"
	test -e "$file" && rm "$file"

	cat $* > "$tmpfile"
	sed -i '/^$/d' "$tmpfile"
	declare -i len=`wc -l "$tmpfile" | cut -d " " -f1`
	while [ $len -ge 0 ]; do
		rand=$(( 1 + len * $RANDOM / 32768 ))
		sed -n "$rand p" "$tmpfile" >> "$file"
		sed -i "$rand d" "$tmpfile"
		len=$len-1
	done
	mv "$file" "$1"
	rm "$tmpfile"
	cat "$1"
fi

#cd - > /dev/null
