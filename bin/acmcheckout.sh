#!/bin/bash
# @param $1: executable to be checked
# @param $2: test input
# @param $3: standard output

# choose your diff executable
dm_installed=$(which diffmerge)
[ dm_installed == "" ] && diffexe=diff || diffexe=diffmerge

"$1" < "$2" > "$1".output
$diffexe "$1".output "$3"
