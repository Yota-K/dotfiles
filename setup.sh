#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "シンボリックリンクを設定します 📝"
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

# 隠しファイルではない設定ファイルにシンボリックリンクを設定する
ln -sfv "$DOTFILES_DIR/cspell.json" "$HOME/cspell.json"

# MEMO: theme.luaはneovimのテーマの設定も共通化するためのモジュールである。
# .config/wezterm/にtheme.luaを配置すればこの処理は不要だが、.config/.weztermディレクトリにあるとweztermの設定を行う用途みたいな感じで違和感があるので、
# dotfilesのトップレベルに配置している。
#
# theme.luaはweztermの追加モジュールとしての役割も兼ねているので、~/.config/wezterm/ に配置している。
# https://wezfurlong.org/wezterm/config/files.html#making-your-own-lua-modules
mkdir -p ~/.config/wezterm

if [ -d "$HOME/.config/wezterm" ]; then
  ln -sfv "$DOTFILES_DIR/theme.lua" "$HOME/.config/wezterm/theme.lua"
fi
echo "シンボリックリンクの設定が完了しました ✅"
echo ""

echo "cspellの設定をします 📝"
# vimのスペルチェック用の辞書をダウンロードして、cspellの設定ファイルを作成する
mkdir -p ~/.local/share/cspell
if [ ! -f ~/.local/share/cspell/vim.txt.gz ]; then
  vim_dictionary_url="https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
  # -f: サーバーエラーでサイレントに失敗する
  # -s: プログレスメーターやエラーメッセージを表示しない
  # -S: -sとともに使用すると、失敗した場合にcurlにエラーメッセージが表示される
  # -L: リダイレクトを追う。アクセスしたページが移動していた場合、もう１度移動先にリクエストを送る。
  # -o: ダウンロードしたファイルを保存する
  curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "$vim_dictionary_url"
fi
# 業務で使用する単語のような公開したらまずい単語を登録するための、ユーザー辞書を作成する
touch ~/.local/share/cspell/user.txt

echo "cspellの設定が完了しました ✅"
