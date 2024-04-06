#########################################
# 環境変数
#########################################

# voltaのPATH
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Voltaでpnpmを使用できるようにする
# まだ実験段階なため、利用する際は環境変数へフラグを立てる必要がある
# https://docs.volta.sh/advanced/pnpm
set VOLTA_FEATURE_PNPM 1

# golangのPATH
set -x GOPATH $HOME/go
set -x PATH $PATH:$GOPATH/bin

# GOPATHの外でプロジェクトを扱えるようにする
set -x GO111MODULE on

# RustのPATH
set PATH $HOME/.cargo/bin $PATH

# RubyのPATH
set PATH $HOME/.rbenv/shims:/usr/local/bin:$PATH

#########################################
# エイリアス
#########################################

alias home='cd ~/Documents'
alias ..='cd ..'

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

# tmux全体を終了
alias tmuxKillAll='tmux kill-server'

# dotfilesのエイリアス
alias dotfiles='cd ~/dotfiles && v'

# weztermで画像を表示
alias imgcat='wezterm imgcat'

# lsコマンドをezaに変更
# Git管理下の場合は、Gitのステータスを表示する
alias ls='eza --git'

# tree
# - treeオプションを有効にする
# - 再帰の深さは3階層まで有効にする
# - 隠しファイルを表示する
# - node_modules, .git, .cache, .nextは検索対象から除外
alias tree='eza -T -L 3 -a -I "node_modules|.git|.cache|.next"'

#########################################
# CLIの色の変更
#########################################

set fish_color_normal         brwhite
set fish_color_autosuggestion brblack
set fish_color_cancel         brcyan
set fish_color_command        brpurple
set fish_color_comment        brblack
set fish_color_cwd            brred
set fish_color_end            brwhite
set fish_color_error          brred
set fish_color_escape         brcyan
set fish_color_host           brgreen
set fish_color_host_remote    bryellow
set fish_color_match          brcyan --underline
set fish_color_operator       brpurple
set fish_color_param          brred
set fish_color_quote          brgreen
set fish_color_redirection    brcyan
set fish_color_search_match   --background=brblack
set fish_color_selection      --background=brblack
set fish_color_user           brblue

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

# パスを指定してtigを開く
function topen
  if string length -q -- $argv
    set dir $argv
    cd $dir

    # 指定したディレクトリに.gitがあるかのチェック
    if test -d .git
      tiga
    else
      echo 'Not found .git directory.'
      return 0
    end

  else
    echo 'Please setting args.'
    return 0
  end
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

# iterm
export CLICOLOR=1
export TERM=xterm-256color

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# direnv
# https://github.com/direnv/direnv/blob/master/docs/hook.md#fish
direnv hook fish | source

# starship
starship init fish | source

#########################################
# MEMO
#########################################

# fishの文法
# MEMO: https://www.gfd-dennou.org/member/hiroki/homepage/main009.html

# Fish Shellでコマンドの実行結果を変数に代入する方法
# https://efcl.info/2013/0520/res3282/
