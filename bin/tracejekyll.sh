# Filename: tracejekyll.sh
# Author:   LIU Yang
# Create Time: Wed Aug 14 14:54:06 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Create a jekyll serve and trace it, with source given by $1 or file $cache

cache="$HOME/.cache/jekyllsource"
test -f "$cache" && src=`cat "$cache"`
test -n "$1"     && src="$1"
test -z "$src" && echo "Jekyll source path not given! Aborting..." && exit
# update cache
test -d "$HOME/.cache" || mkdir -p "$HOME/.cache"
test -f "$cache" || touch "$cache"
if [ "$src" != "$(cat "$cache")" ]; then
	echo "$src" > "$cache"
fi

jekyll serve --watch --trace --source "$src" --p 5432 --destination /tmp
