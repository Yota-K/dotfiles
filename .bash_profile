# nodeのPATH
export PATH=$HOME/.nodebrew/current/bin:$PATH

# zshじゃなくbashを使う
export BASH_SILENCE_DEPRECATION_WARNING=1

# lsした時の色変更
alias ls='ls -G'
export LSCOLORS=Exfxcxdxbxegedabagacad

# プロンプトの表示を変更
PS1="\$ \W > "

#####################
#      Aliases      #
#####################

# Docker
alias dud='docker-compose up -d'
alias dstart='docker-compose start'
alias drestart='docker-compose restart'
alias dstop='docker-compose stop'
alias ddown='docker-compose down'
alias dps='docker ps'
alias dimages='docker images'
alias dexec='docker exec -it'

# tig
alias tiga='tig --all'

# dotfilesをすぐ開く
alias dotfiles='cd && vi dotfiles/'

# 安全策
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# vim
alias v='vi'
