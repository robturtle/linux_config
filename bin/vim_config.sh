#!/bin/bash
./configure --with-features=huge \
--enable-rubyinterp \
--enable-pythoninterp \
--enable-perlinterp \
--enable-gui=gtk2 --enable-cscope --prefix=/usr
