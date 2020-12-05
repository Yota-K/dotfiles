#####################
#      Aliases      #
#####################

# lsした時の色変更
alias ls='ls -G'

# Docker
alias dud='docker-compose up -d'
alias dbuild="docker-compose build"
alias dstart='docker-compose start'
alias drestart='docker-compose restart'
alias dstop='docker-compose stop'
alias ddown='docker-compose down'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimages='docker images'
alias dexec='docker exec -it'
alias dvolumels='docker volume ls'

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
alias vstart='cd && cd Documents/ && vi'
