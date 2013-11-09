# Filename: newcdash.sh
# Author:   LIU Yang
# Create Time: Fri Nov  8 19:42:29 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Create a new script to handle CDash tests
#        Invoke it under your project root folder
if [ "$1" = "" ]; then
    echo "Usage: $0 project name"
    exit 1
fi
cp -au ~/Templates/tests .
cp -au ~/Templates/nightly.cmake ~/CDashTests/nightly${1}.cmake
cp -au ~/Templates/CI.cmake ./CI${1}.cmake
echo "Please add cdash support at your CMakeLists.txt"
echo "Please download the CTestConfig.cmake at project root folder"
echo "Please edit file at ./CI${1}.cmake to config Continuous test."
echo "Please edit file at ~/CDashTests/nightly${1}.cmake to config."
