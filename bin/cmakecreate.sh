# Filename: cmakecreate.sh
# Author:   LIU Yang
# Create Time: Thu Oct 31 05:30:23 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: CMake create a new build
if [[ "$1" == "" ]]; then
    Flag="Debug"
else
    Flag="$1"
fi

test -d "$Flag" || mkdir "$Flag"
cd "$Flag"
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE:STRING=$Flag ..
