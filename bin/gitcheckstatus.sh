# Filename: gitcheckstatus.sh
# Author:   LIU Yang
# Create Time: Fri Nov  1 22:39:21 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Invoke `git status` in my git dir "~/git"
gitpath="$HOME/git"
cd "$gitpath"
for d in $(ls); do
    test -d "$d" && cd "$d" || continue
    test -d .git || continue
    echo -e "\e[0;34m*********************************************************"
    echo -e "Repository $d:\e[0;37m"
    git status
    echo -e "\e[0;34m*********************************************************\e[0;37m\n"
    cd ..
done
