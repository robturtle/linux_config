#!/bin/bash
#Description: 
#	copy a file/directory from remote src/dest
#	cooperate with the app parcellite
#args:
#	$1: remote machine's name/address
#	$2: destination directory of local machine
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 2012/12/06
#
#History:
#Special Commands:
#EnvArgs:
if [ $# -gt 0 ]; then
	remote="$1"
	shift
else
	remote="127.0.0.1"
fi
if [ $# -gt 0 ]; then
	dest="$1"
	shift
else
	dest='.'
fi

src=`parcellite -c | xargs`
scp -r "$remote":"$src" "$dest"
