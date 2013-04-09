#!/bin/bash
sudo apt-get install libncurses5-dev
./configure --enable-cscope --enable-perlinterp --enable-pythoninterp --enable-rubyinterp --with-features=huge
make
sudo make install
