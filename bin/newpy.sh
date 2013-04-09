#!/bin/bash
[ "$1" != "" ] && file="$1".py || exit
echo "#!/usr/bin/python" > "$file"
echo "# Filename: ${1}.py"    >> "$file"
chmod +x "$file"
