#!/bin/bash
test -e CMakeLists.txt || echo "Error: no CMakeLists.txt in current working directory: " $(pwd)
test -e CMakeLists.txt || exit 1

test -d build || cmakemake.sh
cd build/test/

declare -i idx=1
for i in $(ls performance_*); do
	echo -e "\e[0;41;1m";
	echo -e "###############################################";
	echo -e "Running performance case $idx :";
	echo -e "$i";
	echo -e "###############################################";
	echo -e "\e[0m";
	./$i;
	idx=$idx+1;
done
