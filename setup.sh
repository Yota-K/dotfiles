#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "シンボリックリンクを設定します"

if cd "$DOTFILES_DIR"; then
  # cd でdotfilesディレクトリに移動できた場合、gitディレクトリと.DS_Storeファイルを除外し、隠しファイルを検索する
  # cut で3バイト目以降を取得し、リンク先のファイルパスを取得する
  # 例: ./.config/nvim/init.lua
  for file in $(find . -not -path '*.git*' -not -path '*.DS_Store' -path '*/.*' -type f -print | cut -b3-); do
    # リンク先のディレクトリが存在しない場合は作成する
    mkdir -p "$HOME/$(dirname "$file")"

    if [ -L "$HOME/$file" ]; then
      # 既存のシンボリックリンクが存在する場合は上書きして、リンクを登録する際には登録名とリンク先を表示する
      ln -sfv "$DOTFILES_DIR/$file" "$HOME/$file"
    else
      # シンボリックリンクが存在しない場合は、インタラクティブモードでリンクを作成する
      ln -sniv "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
  done
else
 echo "$DOTFILES_DIR が存在しません。"
fi
