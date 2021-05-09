#!/bin/bash
apt-get update
apt-get install sudo

# vim plugを落とすのに必要
echo Install curl
apt-get -y install curl

# 普通にapt-getしただけだと最新版のvimがインストールできなかった
# 参考サイト: https://sourcedigit.com/24976-vim-8-2-released-how-to-install-vim-in-ubuntu-linux/
echo Install Vim
git clone https://github.com/vim/vim.git
cd vim
./configure
sudo apt install ncurses-dev
make
sudo make install
rm -rf vim/

echo Vim Plug setting
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo Install ag
apt-get -y install silversearcher-ag

echo Node.js setting
apt-get -y install nodejs npm yarn

echo export NODE_PATH=/usr/local/lib/node_modules
