if [ -f $1 ]; then
	echo "Please Enter a new script name as an argument!"
	read filename
	filename=${filename%%\.*}
else
	filename=${1%%\.*}
fi

file="$filename.sh"
test -f "$file" && echo "$file already exist! Aborting..." && exit
touch "$file"
chmod +x "$file"

echo "# Filename: ${1}.sh"    >> "$file"
echo "# Author:   LIU Yang"   >> "$file"
echo "# Create Time: $(date)" >> "$file"
echo "# License:     LGPL v2.0+"  >> "$file"
echo "# Contact Me:  JeremyRobturtle@gmail.com" >> "$file"
echo "# Brief:" >> "$file"

test -n "$EDITOR" && "$EDITOR" "$file"
