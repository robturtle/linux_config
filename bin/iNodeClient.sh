#!/bin/sh
if [ "echo $LC_ALL|grep ^zh_CN" != "" ];then
    export LC_ALL=zh_CN.gb2312            
fi 

if [ "echo $LANG|grep ^zh_CN" != "" ];then
    export LANG=zh_CN.gb2312                
fi 

"$HOME/bin/iNodeClient/iNodeClient.sh" &


