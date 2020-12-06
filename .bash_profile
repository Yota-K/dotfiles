# ターミナル起動時に.bashrcを読み込む
if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# nodeのPATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

# zshじゃなくbashを使う
export BASH_SILENCE_DEPRECATION_WARNING=1

# プロンプトの表示を変更
export PS1='\$ \w \[\033[35m\]$(__git_ps1 [%s])\[\033[00m\]\n> '

# lsした時の色変更
export LSCOLORS=Exfxcxdxbxegedabagacad

# Gitのワーキングツリーの状態の把握をしやすいようにする
GIT_PS1_SHOWDIRTYSTATE=true
