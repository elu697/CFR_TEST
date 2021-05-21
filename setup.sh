#!/bin/bash
sudo apt -y update
sudo apt -y upgrade
sudo apt -y full-upgrade
sudo apt -y autoremove
sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git zlib1g-dev libffi-dev automake net-tools

wget https://cefore.net/dlfile.php?file=cefore-0.8.3.zip -O cefore.zip
unzip cefore.zip
cd cefore-0.8.3
export CEFORE_DIR=/usr/local
aclocal
automake
./configure --enable-csmgr --enable-cache
make
sudo make install
ldconfig

sudo sysctl --write net.core.rmem_default=10000000
sudo sysctl --write net.core.wmem_default=10000000
sudo sysctl --write net.core.rmem_max=10000000
sudo sysctl --write net.core.wmem_max=10000000

sudo csmgrdstart
sleep 1
sudo cefnetdstat

sudo cefroute add ccnx:/test udp 127.0.0.1

cefputfile ccnx:/test/cefore.zip
cefgetfile ccnx:/test/cefore.zip
