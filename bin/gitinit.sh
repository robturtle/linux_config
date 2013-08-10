#!/bin/bash
["$1" == ""] && echo "Usage: $0 gitURL" && exit 1
git init
git remote add origin "$1"
git remote add -t devel develol "$1"

touch README.md
touch .gitignore
cp -u ~/Templates/LICENSE-MIT .

git branch master
git config branch.master.remote origin
git config branch.master.merge  refs/heads/master

git checkout -b devel
git config branch.devel.remote  origin
git config branch.devel.merge   refs/heads/devel

git config color.ui true
git config format.pretty oneline

