#!/bin/bash
apk update

echo Install Vim
apk add vim

echo Install bash
apk add bash

echo Install curl
apk add curl

echo Install ag
apk add silversearcher-ag

echo Node.js setting
apk add nodejs npm yarn

echo export NODE_PATH=/usr/local/lib/node_modules

echo Vim Plug setting
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
