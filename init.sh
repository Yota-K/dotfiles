#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

# $DOTFILES_DIRが存在しない場合に、git cloneコマンドを使用してリポジトリをcloneする。
if [ ! -d "$DOTFILES_DIR" ]; then
  echo 'dotfilesリポジトリをcloneします'
  git clone git@github.com:Yota-K/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

# シンボリックリンクの設定
# 1. git ls-filesを使用して、カレントディレクトリのGit管理下のファイルのリストを取得する。
# 2. .* *で、dotfiles管理下の全てのファイルを取得する。
# 3. 各ファイルが"."（カレントディレクトリを表す）、".."（親ディレクトリを表す）または ".git" ではない場合シンボリックリンクを作成する。
git ls-files | for file in .* *; do
  if [ "$file" != '.' ] && [ "$file" != '..' ] && [ "$file" != '.git' ]; then
    echo "シンボリックリンクを設定します: $file"
    ln -sfn "$DOTFILES_DIR/$file" "$HOME/$file"
  fi
done
