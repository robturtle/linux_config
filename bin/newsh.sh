if [ -f $1 ]; then
	echo "Please Enter a new script name as an argument!"
	read filename
	filename=${filename%%\.*}
else
	filename=${1%%\.*}
fi

cp ~/bin/bash_template.txt "$filename.sh"
chmod +x "$filename.sh"
exit 0
