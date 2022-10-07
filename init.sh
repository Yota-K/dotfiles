# -e・・・エラーが処理を中断
# -u・・・未定義の変数を使おうとすると処理中断
#!/bin/bash -eu
path=~/dotfiles

cd ~/

# ディレクトリが存在しない場合は作成する
if [ ! -e ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim
fi

if [ ! -e ~/iterm2 ]; then
  mkdir -p ~/iterm2
fi

if [ ! -e ~/.config/ranger/colorschemes ]; then
  mkdir -p ~/.config/ranger/colorschemes
fi
# ~/dotfilesに戻る
cd $path

if [ $path ]; then
  ln -s $PWD/.agignore ~/.agignore
  ln -s $PWD/.bash_profile ~/.bash_profile
  ln -s $PWD/.bashrc ~/.bashrc
  ln -s $PWD/.tigrc ~/.tigrc
  ln -s $PWD/.tmux.conf ~/.tmux.conf
  ln -s $PWD/Brewfile ~/Brewfile

  # nvim
  ln -s $PWD/.config/nvim/init.lua ~/.config/nvim/init.lua
  ln -sf $PWD/.config/nvim/lua ~/.config/nvim/lua
  ln -s $PWD/.vim/indent ~/.config/nvim/indent
  ln -s $PWD/.vim/coc-settings.json ~/.config/nvim/coc-settings.json

  # iterm2
  ln -s $PWD/iterm2/tron.itermcolors ~/iterm2/

  # ranger
  ln -s $PWD/ranger/colorschemes/myscheme.py ~/.config/ranger/colorschemes/myscheme.py

  # fish
  ln -s $PWD/fish/config.fish ~/.config/fish/config.fish
  ln -s $PWD/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
fi
