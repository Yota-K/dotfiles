#########################################
# 環境変数
#########################################

# nodeのPATH
set -x PATH $HOME/.nodebrew/current/bin:$PATH

# golangのPATH
set -x GOPATH $HOME/go
set -x PATH $PATH:$GOPATH/bin

# GOPATHの外でプロジェクトを扱えるようにする
set -x GO111MODULE on

#########################################
# エイリアス
#########################################

alias ..='cd ..'

# lsした時の色変更
alias ls='ls -G'

# Docker
alias dup='docker-compose up'
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
alias dvolume='docker volume'
alias dvolumels='docker volume ls'
alias dvolumerm='docker volume rm'
alias dlogs='docker logs'
alias dlogsf='docker logs -f'

# git
alias gpush='git push'
alias gpull='git pull'
alias gmerge='git merge'
alias gfetch='git fetch --prune'
alias gcm='git commit'
alias gst='git status'
alias gct='git checkout'
alias gctb='git checkout -b'
alias gb='git branch'
alias gbl='git branch -l'
alias gbla='git branch -la'
alias glogo='git log --oneline'
alias gmergetool='git mergetool -t vimdiff'
alias gstash='git stash'
alias gspop='git stash pop'
alias gtag='git tag'
alias gcherrypick='git cherry-pick'
alias gresethard='git reset --hard'

# tig
alias tiga='tig --all'

# 安全策
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# vim
alias v='nvim'

# tmux
alias tmuxRestart='tmux attach'
alias tmuxKillAll='tmux kill-server'

# ranger
alias r='ranger'

# tree
# node_modulesを除外 エイリアスを無視したい場合は、$ \tree
# ※ fishだと使えない
alias tree="tree -I node_modules -L 3"

#########################################
# 関数
#########################################

# Dockerコンテナの中でUNIXコマンドを実行する
# $argv[1]・・・コンテナの名前
# $argv[2]・・・実行したいコマンドを''か""で囲って渡す 'node -v'
function dshell_invoke
  docker-compose run --rm $argv[1] sh -c $argv[2]
end

# ワークツリーで変更済みのファイルにタグをつけてコミットする
function gtag_commit
  git tag -a $argv[1] -m $argv[1] -a
end

# 指定したファイル・ディレクトリをnvimで開く
function vopen
  v $argv[1]
end

# 魚を表示する
function fish_logo \
    --description="Fish-shell colorful ASCII-art logo" \
    --argument-names outer_color medium_color inner_color mouth eye

    # defaults:
    [ $outer_color  ]; or set outer_color  'red'
    [ $medium_color ]; or set medium_color 'f70'
    [ $inner_color  ]; or set inner_color  'yellow'
    [ $mouth ]; or set mouth '['
    [ $eye   ]; or set eye   'O'

    set usage 'Usage: fish_logo <outer_color> <medium_color> <inner_color> <mouth> <eye>
See set_color --help for more on available colors.'

    if contains -- $outer_color '--help' '-h' '-help'
        echo $usage
        return 0
    end

    # shortcuts:
    set o (set_color $outer_color)
    set m (set_color $medium_color)
    set i (set_color $inner_color)

    if test (count $o) != 1; or test (count $m) != 1; or test (count $i) != 1
        echo 'Invalid color argument'
        echo $usage
        return 1
    end

    echo '                 '$o'___
  ___======____='$m'-'$i'-'$m'-='$o')
/T            \_'$i'--='$m'=='$o')
'$mouth' \ '$m'('$i$eye$m')   '$o'\~    \_'$i'-='$m'='$o')
 \      / )J'$m'~~    '$o'\\'$i'-='$o')
  \\\\___/  )JJ'$m'~'$i'~~   '$o'\)
   \_____/JJJ'$m'~~'$i'~~    '$o'\\
   '$m'/ '$o'\  '$i', \\'$o'J'$m'~~~'$i'~~     '$m'\\
  (-'$i'\)'$o'\='$m'|'$i'\\\\\\'$m'~~'$i'~~       '$m'L_'$i'_
  '$m'('$o'\\'$m'\\)  ('$i'\\'$m'\\\)'$o'_           '$i'\=='$m'__
   '$o'\V    '$m'\\\\'$o'\) =='$m'=_____   '$i'\\\\\\\\'$m'\\\\
          '$o'\V)     \_) '$m'\\\\'$i'\\\\JJ\\'$m'J\)
                      '$o'/'$m'J'$i'\\'$m'J'$o'T\\'$m'JJJ'$o'J)
                      (J'$m'JJ'$o'| \UUU)
                       (UU)'(set_color normal)
end


#########################################
# その他
#########################################

# Remove greeting messsage
set fish_greeting

# gitのブランチとstatusを表示させるのに必要
# https://qiita.com/mom0tomo/items/b593c0e98c1eea70a114

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
