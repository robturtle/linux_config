#!/bin/bash
#Description: 
#	make cscope index file
#args:
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#
#History:
#Special Commands:
#EnvArgs:

find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.c??" > cscope.files
cscope -bkq -i cscope.files
ctags -R
mv cscope.out .cscope.out
mv tags .tags
