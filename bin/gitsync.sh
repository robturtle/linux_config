#!/bin/bash
# Filename: sync.sh
# Author:   LIU Yang
# Create Time: Thu May  2 16:41:23 CST 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Description: Push changes from all local repos
#              under current working directory
for d in $(ls); do 
    test -d "$d" || continue
    cd "$d"
    echo "pulling $d ..."
    git pull
    echo "pushing $d ..."
    git push
    cd ..
done
