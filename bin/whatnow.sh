#!/bin/bash
#Description: 
#	part of agenda,
#	main access,
#	invoke scripts to give mission and ask if you'll accept
#args:
#	none
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 12/7/30
#
#History:
#Special Commands:
#EnvArgs:

path="$HOME/bin/agenda"
cd $path > /dev/null

#check if there is any active mission
#if there is not, give mission and ask if you'll accept
./ck_active_mission.sh || ./give_mission.sh

cd - >/dev/null
