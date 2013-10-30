#!/bin/bash
test -e CMakeLists.txt || echo "Error: CMakeLists.txt not found at " $(pwd)
test -e CMakeLists.txt || exit 1

if [[ "$1" == "" ]]; then
    for pathname in "Release" "build"; do
        test -d "$pathname" && path="$pathname" && break
    done
    if [[ "$path" == "" ]]; then
        echo "Error: Can't find a build directory. Try to call cmakecreate.sh first."
        exit 2
    fi
else
    path="$1"
    test -d "$path" || echo "Build path $path not found!"
    test -d "$path" || exit 3
fi

cd "$path"
sudo make install
