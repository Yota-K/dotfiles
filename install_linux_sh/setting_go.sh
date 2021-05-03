#!/bin/bash
cd ~/

# Goの設定
if [ -e /go ]; then
  echo export GOPATH=$HOME/go
  echo export PATH=$PATH:$GOPATH/bin
  GO111MODULE=on go get golang.org/x/tools/gopls
fi
