#!/bin/bash
# Filename: newblog.sh
# Author:   LIU Yang
# Create Time: Tue Aug 13 01:33:22 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Create new file with Jekyll's naming style

if [ "$1" == "" ]; then
	echo "Usage: $0 title"
	echo "NOTE: do not use quotes"
	exit
fi

today="$(date -d today +"%Y-%m-%d")"

# Concat the title in words with '-'
title=$1
shift
for i in $*; do
	title="$title-$i"
done

filename="$today-$title.md"
echo -e "---\nlayout: post\n---" > "$filename"
$EDITOR "$filename"
