#!/bin/bash
test -e CMakeLists.txt || echo "Error: CMakeLists.txt not found at " $(pwd)
test -e CMakeLists.txt || exit 1

test -d build && rm -rf build
rm -rf CMakeFiles/ Makefile *.elf CTestTestfile.cmake cmake_install.cmake CMakeCache.txt Testing build 2>/dev/null
