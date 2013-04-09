#!/bin/bash
#Description: 
#	part of agenda,
#	can add a new issue
#args:
#	$1: weight
#	$2: class
#	$3: type
#	$4: context !!!NOTICE: no blank keys!!!
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/8/4
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin/agenda"
cd $path > /dev/null

vim "$USER.agd"

cd - > /dev/null
