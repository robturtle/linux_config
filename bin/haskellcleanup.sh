# Filename: cleanup.sh
# Author:   LIU Yang
# Create Time: Sat Apr 26 00:57:40 CST 2014
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Clean up Haskell targets
rm -f *.o
rm -f *.hi

if [ "$1" == "-f" ]; then
    rm_opt="-f"
else
    rm_opt="-i"
fi

for f in `ls`; do
    file "$f" | grep 'executable' >/dev/null && rm $rm_opt "$f"
done
