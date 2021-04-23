# -e・・・エラーが処理を中断
# -u・・・未定義の変数を使おうとすると処理中断
#!/bin/bash -eu
path=~/dotfiles

cd ~/

# ディレクトリが存在しない場合は作成する
if [ ! -e ~/iterm2 ]; then
  mkdir -p ~/iterm2
fi

if [ ! -e ~/.vim ]; then
  mkdir -p ~/.vim
fi

# ~/dotfilesに戻る
cd $path

if [ $path ]; then
  ln -s $PWD/.agignore ~/.agignore
  ln -s $PWD/.bash_profile ~/.bash_profile
  ln -s $PWD/.bashrc ~/.bashrc
  ln -s $PWD/.tigrc ~/.tigrc
  ln -s $PWD/.tmux.conf ~/.tmux.conf
  ln -s $PWD/.vimrc ~/.vimrc
  ln -s $PWD/Brewfile ~/Brewfile

  # iterm2
  ln -s $PWD/iterm2/tron.itermcolors ~/iterm2/

  # vim
  ln -s $PWD/.vim/colors ~/.vim/colors
  ln -s $PWD/.vim/indent ~/.vim/indent
  ln -s $PWD/.vim/templates ~/.vim/templates
  ln -s $PWD/.vim/vim_settings ~/.vim/vim_settings
  ln -s $PWD/.vim/coc-settings.json ~/.vim/coc-settings.json
fi
