# Filename: INSTALL.sh
# Author:   LIU Yang
# Create Time: Wed Oct 30 22:13:31 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Make symlinks to your $HOME.
for i in ".zsh" ".vimrc" ".zshrc" "bin" "Templates" ".gitconfig" \
    ".percol.d" ".Rprofile"; do
    if [ -f "${HOME}/$i" ] || [ -d "${HOME}/$i" ]; then
        echo "$i already existed. Not installed..."
    else
        echo "Install $i into ${HOME}"
        ln -s $(pwd)/"$i" ~
    fi
done

QPdir="${HOME}/.config/fcitx/data"
if [ -d "$QPdir" ]; then
    echo "Install QuickPhrase.md into $QPdir"
    ln -s QuickPhrase.mb "$QPdir"
else
    echo "fcitx configure folder not found. QuickPhrase.md not installed."
fi

# Install my keyboard layout to /etc/rc.local
#echo "Install keyboard layout..."
#sudo cp jeremy.kmap /usr/share

is_gentoo=$(uname -a | grep "gentoo")
if [ "$is_gentoo" ]; then
    echo "Install keymap under CLI (CapsLock as Control) ..."
    sudo cp 0kmap.start /etc/local.d/
    sudo chmod +x /etc/local.d/0kmap.start
else
    echo "Not gentoo. Please install key map manually."
    echo "For instance, in ubuntu, you can add this line into"
    echo "/etc/rc.local:"
    echo "    /usr/bin/env loadkeys /usr/share/jeremy.kmap"
fi
