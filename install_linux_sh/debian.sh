#!/bin/bash
apt-get update

echo Install Vim
apt-get -y install vim

echo Install curl
apt-get -y install curl

echo Install ag
apt-get -y install silversearcher-ag

echo Node.js setting
apt-get -y install nodejs npm yarn

echo export NODE_PATH=/usr/local/lib/node_modules

echo Vim Plug setting
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
