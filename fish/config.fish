#####################
# 環境変数          #
#####################

# nodeのPATH
set -x PATH $HOME/.nodebrew/current/bin:$PATH

# golangのPATH
set -x GOPATH $HOME/go
set -x PATH $PATH:$GOPATH/bin

# GOPATHの外でプロジェクトを扱えるようにする
set -x GO111MODULE on

# Gitのワーキングツリーの状態の把握をしやすいようにする
set -x GIT_PS1_SHOWDIRTYSTATE true

#####################
# Aliases           #
#####################

alias ..='cd ..'

# lsした時の色変更
alias ls='ls -G'

# Docker
alias dud='docker-compose up -d'
alias dbuild='docker-compose build'
alias dstart='docker-compose start'
alias drestart='docker-compose restart'
alias dstop='docker-compose stop'
alias ddown='docker-compose down'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dimages='docker images'
alias dexec='docker exec -it'
alias dvolumels='docker volume ls'
alias dlogs='docker logs'
alias dlogsf='docker logs -f'

# git
alias gmergetool='git mergetool -t vimdiff'
alias gst='git status'
alias gcm='git commit'
alias gct='git checkout'
alias gb='git branch'
alias gbl='git branch -l'
alias gbla='git branch -la'
alias glogo='git log --oneline'

# tig
alias tiga='tig --all'

# 安全策
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# vim
alias v='vi'

# tmux
alias tmuxRestart='tmux attach'
alias tmuxKillAll='tmux kill-server'

# ranger
alias r='ranger'

# gitのブランチとstatusを表示させるのに必要
# https://qiita.com/mom0tomo/items/b593c0e98c1eea70a114
#
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
