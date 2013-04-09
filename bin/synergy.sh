#!/bin/bash
#Description: 
#	link to the host's keyboard and mouse
#args:
#	host's ip address
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: 2012/12/4
#
#History:
#Special Commands:
#EnvArgs:

if [ "$1" = "" ]; then
	addr="$1"
else
	addr=192.168.169.2
fi

synergyc --daemon "$addr"
