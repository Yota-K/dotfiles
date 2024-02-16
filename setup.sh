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

echo "cspellの設定をします"
# vimのスペルチェック用の辞書をダウンロードして、cspellの設定ファイルを作成する
mkdir -p ~/.local/share/cspell
if [ ! -f ~/.local/share/cspell/vim.txt.gz ]; then
  vim_dictionary_url="https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
  curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "$vim_dictionary_url"
fi

# cspell.jsonは隠しファイルではないため、ループではなく直接リンクを作成している
ln -sfv "$DOTFILES_DIR/cspell.json" "$HOME/cspell.json"

# weztermの追加モジュールは、~/.config/wezterm/ に配置しないといけない
# ~/.config/weztermディレクトリが存在しない場合は作成して、~/theme.luaからシンボリックリンクを設定してファイルを参照できるようにする
#
# MEMO: .config/wezterm/にtheme.luaを配置すればこの処理は不要だが、theme.luaはneovimのテーマの設定も共通化するためのモジュールである。
# .config/.weztermディレクトリにあるとweztermの設定を行うファイルみたいな感じで違和感があるので、dotfilesのトップレベルに配置している。
mkdir -p ~/.config/wezterm

if [ -d "$HOME/.config/wezterm" ]; then
  ln -sfv "$DOTFILES_DIR/theme.lua" "$HOME/.config/wezterm/theme.lua"
fi
