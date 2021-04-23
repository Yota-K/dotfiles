# -e・・・エラーが処理を中断
# -u・・・未定義の変数を使おうとすると処理中断
#!/bin/bash -eu

path=~/dotfiles
root_path=~/

ln -sf $PWD/.agignore ~/.agignore
ln -sf $PWD/.bash_profile ~/.bash_profile
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.tigrc ~/.tigrc
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/Brewfile ~/Brewfile

cd $root_path

if [ ! -e ~/iterm2 ]; then
  mkdir -p ~/iterm2
fi

if [ ! -e ~/.vim ]; then
  mkdir -p ~/.vim
fi

# ~/dotfilesに戻る
cd $path

if [ $path ]; then
  ln -sf $PWD/iterm2/tron.itermcolors ~/iterm2/
fi
