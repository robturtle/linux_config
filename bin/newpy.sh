#!/bin/bash
[ "$1" != "" ] && file="$1".py || exit
echo "#!/usr/bin/env python" > "$file"
echo "# Filename: ${1}.py"    >> "$file"
chmod +x "$file"
