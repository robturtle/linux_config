#!/bin/bash
# Profile:
#   Detect WWW, SSH, FTP and Mail services status.
# History:
#   2005-08-28 18:32:52 VBird    First release
#   2013-03-17 11:00:51 Yang     Copy and modified prompt
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "Detecting Linux's services:"
echo -e "www, ftp, ssh, mail will be detect...\n"

testing=$(netstat -tuln | grep ":80")
if [ "$testing" != "" ]; then
	echo "WWW is running in your system."
fi

testing=$(netstat -tuln | grep ":22")
if [ "$testing" != "" ]; then
	echo "SSH is running in your system."
fi

testing=$(netstat -tuln | grep ":21")
if [ "$testing" != "" ]; then
	echo "FTP is running in your system."
fi

testing=$(netstat -tuln | grep ":25")
if [ "$testing" != "" ]; then
	echo "Mail is running in your system."
fi
