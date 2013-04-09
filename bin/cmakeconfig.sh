#!/bin/bash
test -e CMakeLists.txt || echo "Error: no CMakeLists.txt in current working directory: " $(pwd)
test -e CMakeLists.txt || exit 1

test -d build || mkdir build
cd build
ccmake ..
