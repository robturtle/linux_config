# Filename: INSTALL.sh
# Author:   LIU Yang
# Create Time: Wed Oct 30 22:13:31 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Make symlinks to your $HOME.
ln -s $(pwd)/.zsh ~
ln -s $(pwd)/.vimrc ~
ln -s $(pwd)/.zshrc ~
ln -s $(pwd)/bin ~
ln -s $(pwd)/Templates ~

# Install my keyboard layout to /etc/rc.local
echo "Install keyboard layout..."
sudo cp jeremy.kmap /usr/share

is_gentoo=$(uname -a | grep "gentoo")
if [ "$is_gentoo" ]; then
    sudo cp 0kmap.start /etc/local.d/
    sudo chmod +x /etc/local.d/0kmap.start
else
    echo "Do it yourself"
fi
