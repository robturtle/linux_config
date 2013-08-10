#!/bin/bash
[ "$1" != "" ] && file="$1".py || exit
echo "#!/usr/bin/env python" > "$file"
echo "# Filename: ${1}.sh"    >> "$file"
echo "# Author:   LIU Yang"   >> "$file"
echo "# Create Time: $(date)" >> "$file"
echo "# License:     LGPL v2.0+"  >> "$file"
echo "# Contact Me:  JeremyRobturtle@gmail.com" >> "$file"
chmod +x "$file"
