path=~/dotfiles

if [ $path ]; then
  ln -sf $PWD/.agignore ~/.agignore
  ln -sf $PWD/.bash_profile ~/.bash_profile
  ln -sf $PWD/.bashrc ~/.bashrc
  ln -sf $PWD/.tigrc ~/.tigrc
  ln -sf $PWD/.tmux.conf ~/.tmux.conf
  ln -sf $PWD/.vimrc ~/.vimrc
  ln -sf $PWD/Brewfile ~/Brewfile
fi
