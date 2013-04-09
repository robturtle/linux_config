#!/bin/bash
test -e CMakeLists.txt || echo "Error: CMakeLists.txt not found at " $(pwd)
test -e CMakeLists.txt || exit 1

test -d build || cmakemake.sh
cd build
sudo make install
