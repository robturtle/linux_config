#!/bin/bash
[ "$1" != "" ] && file="$1".py || exit
version=2.7
echo "#!/usr/bin/env python${version}" > "$file"
echo "# Filename: ${1}.sh"    >> "$file"
echo "# Author:   LIU Yang"   >> "$file"
echo "# Create Time: $(date)" >> "$file"
echo "# License:     LGPL v2.0+"  >> "$file"
echo "# Contact Me:  JeremyRobturtle@gmail.com" >> "$file"
chmod +x "$file"
