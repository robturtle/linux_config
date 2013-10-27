#!/bin/bash
test -e CMakeLists.txt || echo "Error: CMakeLists.txt not found at " $(pwd)
test -e CMakeLists.txt || exit 1

test -d build || mkdir build
cd build
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && make
