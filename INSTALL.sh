# Filename: INSTALL.sh
# Author:   LIU Yang
# Create Time: Wed Oct 30 22:13:31 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Make symlinks to your $HOME. If you already have this files,
#        I ll rename them as origin_name.old.
test -e ~/.vimrc       && mv ~/.vimrc ~/.vimrc.old             
ln -s $(pwd)/.vimrc ~
test -e ~/.zshrc       && mv ~/.zshrc ~/.zshrc.old             
ln -s $(pwd)/.zshrc ~
test -e ~/.zsh_aliases && mv ~/.zsh_aliases ~/.zsh_aliases.old 
ln -s $(pwd)/.zsh_aliases ~
test -e ~/.zshrc.zni   && mv ~/.zshrc.zni ~/.zshrc.zni.old     
ln -s $(pwd)/.zshrc.zni ~
test -e ~/bin          && mv ~/bin ~/bin.old                   
ln -s $(pwd)/bin ~
test -e ~/Templates    && mv ~/Templates ~/Templates.old       
ln -s $(pwd)/Templates ~
