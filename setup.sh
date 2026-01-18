#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "$DOTFILES_DIR が存在しません。"
  exit 1
fi

echo "シンボリックリンクを設定します 📝"

# gitディレクトリと.DS_Storeファイルを除外し、隠しファイルを検索する
find "$DOTFILES_DIR" -not -path '*.git*' -not -name '.DS_Store' -path '*/.*' -type f -print0 | while IFS= read -r -d '' filepath; do
  # $DOTFILES_DIR/ を除去して相対パスを取得
  file="${filepath#$DOTFILES_DIR/}"

  # リンク先のディレクトリが存在しない場合は作成する
  mkdir -p "$HOME/$(dirname "$file")"

  if [ -L "$HOME/$file" ]; then
    # 既存のシンボリックリンクが存在する場合は上書き
    ln -sfv "$DOTFILES_DIR/$file" "$HOME/$file"
  else
    # シンボリックリンクが存在しない場合は、インタラクティブモードでリンクを作成する
    ln -sniv "$DOTFILES_DIR/$file" "$HOME/$file"
  fi
done

# 隠しファイルではない設定ファイルにシンボリックリンクを設定する
ln -sfv "$DOTFILES_DIR/cspell.json" "$HOME/cspell.json"

# theme.luaはneovimとweztermで共有するテーマ設定モジュール
# https://wezfurlong.org/wezterm/config/files.html#making-your-own-lua-modules
mkdir -p ~/.config/wezterm
ln -sfv "$DOTFILES_DIR/theme.lua" "$HOME/.config/wezterm/theme.lua"

echo "シンボリックリンクの設定が完了しました ✅"
echo ""

echo "Claude Codeのstatusline.shに実行権限を付与します 📝"
[ -f "$DOTFILES_DIR/.claude/statusline.sh" ] && chmod -v +x "$DOTFILES_DIR/.claude/statusline.sh"
echo "実行権限の付与が完了しました ✅"
echo ""

echo "cspellの設定をします 📝"
mkdir -p ~/.local/share/cspell

if [ ! -f ~/.local/share/cspell/vim.txt.gz ]; then
  vim_dictionary_url="https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
  curl -fsSLo ~/.local/share/cspell/vim.txt.gz --create-dirs "$vim_dictionary_url"
fi

touch ~/.local/share/cspell/user.txt

echo "cspellの設定が完了しました ✅"
echo ""
