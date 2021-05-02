#!/bin/bash

# Copyright (c) 2016 Kohei Arao
# https://github.com/koara-local/dotfiles/edit/master/bin/get_os_info
# Released under the Unlicense
# http://unlicense.org/
# 参考: https://qiita.com/koara-local/items/1377ddb06796ec8c628a

# Get Linux distribution name
get_os_distribution() {
  if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      # Check Ubuntu or Debian
      if [ -e /etc/lsb-release ]; then
        # Ubuntu
        distri_name="ubuntu"
      else
        # Debian
        distri_name="debian"
      fi
    elif [ -e /etc/fedora-release ]; then
      # Fedra
      distri_name="fedora"
    elif [ -e /etc/redhat-release ]; then
      if [ -e /etc/oracle-release ]; then
        # Oracle Linux
        distri_name="oracle"
      else
        # Red Hat Enterprise Linux
        distri_name="redhat"
      fi
    elif [ -e /etc/arch-release ]; then
      # Arch Linux
      distri_name="arch"
    elif [ -e /etc/turbolinux-release ]; then
      # Turbolinux
      distri_name="turbol"
    elif [ -e /etc/SuSE-release ]; then
      # SuSE Linux
      distri_name="suse"
    elif [ -e /etc/mandriva-release ]; then
      # Mandriva Linux
      distri_name="mandriva"
    elif [ -e /etc/vine-release ]; then
      # Vine Linux
      distri_name="vine"
    elif [ -e /etc/gentoo-release ]; then
      # Gentoo Linux
      distri_name="gentoo"
    elif [ -e /etc/alpine-release ]; then
      # Alpine Linux
      distri_name="alpine"
    else
      # Other
      distri_name="unkown"
  fi

  echo ${distri_name}
}

# golang_setting() {
# 
# }

get_os_distribution
os_distribution=`get_os_distribution`

if [ "${os_distribution}" = "alpine" ]; then
  apk update

  echo Install Vim
  apk add vim

  echo Install bash
  apk add bash

  echo Install curl
  apk add curl

  echo Install ag
  apk add silversearcher-ag

  echo Vim Plug setting
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  echo Node.js setting
  apk add nodejs npm yarn
fi
