if [ -f $1 ]; then
	echo "Please Enter a new script name as an argument!"
	read filename
	filename=${filename%%\.*}
else
	filename=${1%%\.*}
fi

cp ~/bin/bash_template.txt "$filename.sh"
chmod +x "$filename.sh"
file="$filename.sh"
echo "# Filename: ${1}.sh"    >> "$file"
echo "# Author:   LIU Yang"   >> "$file"
echo "# Create Time: $(date)" >> "$file"
echo "# License:     LGPL v2.0+"  >> "$file"
echo "# Contact Me:  JeremyRobturtle@gmail.com" >> "$file"
