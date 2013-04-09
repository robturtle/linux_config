#!/bin/bash
#Description: 
#	update local apt sources, store in /home/jeremy/apt-source/Packges.gz
#
#	Author: LiuYang
#	ContectMe: JeremyRobturtle@gmail.com
#	License: GPL v2.0
#	LastModified: ???????????
#
#History:
#Special Commands:
#EnvArgs:

cd /media/LinuxWorkstation
sudo cp -au /var/cache/apt/archives/* /media/LinuxWorkstation/apt-source
sudo dpkg-scanpackages apt-source /dev/null | gzip > apt-source/Packages.gz
cd -
