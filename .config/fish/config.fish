# NOTE
# fishの文法
# @see https://www.gfd-dennou.org/member/hiroki/homepage/main009.html
# 
# Fish Shellでコマンドの実行結果を変数に代入する方法
# https://efcl.info/2013/0520/res3282/

#########################################
# 環境変数
#########################################

# ユーザー個別の設定が書き込まれるディレクトリを.configに変更
set -gx XDG_CONFIG_HOME "$HOME/.config"

# brewのPATH
set -gx PATH /opt/homebrew/bin $PATH

# voltaのPATH
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Voltaでpnpmを使用できるようにする
# まだ実験段階なため、利用する際は環境変数へフラグを立てる必要がある
# https://docs.volta.sh/advanced/pnpm
set VOLTA_FEATURE_PNPM 1

# golangのPATH
set -gx GOPATH $HOME/go
set -gx PATH $PATH:$GOPATH/bin

# GOPATHの外でプロジェクトを扱えるようにする
set -gx GO111MODULE on

# RustのPATH
set -gx PATH $HOME/.nix-profile/.cargo/bin $PATH

# RubyのPATH
set -gx PATH $HOME/opt/homebrew/bin/rbenv $PATH

# nixのPATH
set -gx PATH $HOME/.nix-profile/bin $PATH

# pyenvのPATH
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH

if type -q pyenv
  pyenv init - | source
end

#########################################
# エイリアス
#########################################

alias ..='cd ..'
alias dotfiles='cd ~/dotfiles && v'
alias home='cd ~/Documents'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

#########################################
# ツールごとのエイリアス・関数
#########################################

# claude
alias claudesize='du -sh ~/.claude/ && du -sh ~/.claude/* | sort -h'

# Docker

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

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

# Dockerコンテナの中でUNIXコマンドを実行する
# $argv[1]・・・コンテナの名前
# $argv[2]・・・実行したいコマンドを''か""で囲って渡す 'node -v'
function dshell_invoke
  if test (count $argv) -ne 2
    echo "Usage: dshell_invoke <container_name> '<command>'"
    return 1
  end
  docker-compose run --rm $argv[1] sh -c $argv[2]
end

# eza
# lsコマンドをezaに変更
# Git管理下の場合は、Gitのステータスを表示する
alias ls='eza --git'

# tree
# - treeオプションを有効にする
# - 再帰の深さは3階層まで有効にする
# - 隠しファイルを表示する
# - node_modules, .git, .cache, .nextは検索対象から除外
alias tree='eza -T -L 3 -a -I "node_modules|.git|.cache|.next"'

# fzf

# 履歴検索してコマンドラインにセット
function fzf_history
  history | fzf --tac | read -l cmd
  if test -n "$cmd"
    commandline --replace "$cmd"
  end
end

alias h='fzf_history'

# git
alias gpush='git push'
alias gpull='git pull'
alias gfetch='git fetch --prune'
alias gcm='git commit'
alias gst='git status'
alias gct='git switch'
alias gctb='git switch -c'
alias gb='git branch'
alias gbl='git branch -l'
alias gbla='git branch -la'
alias glogo='git log --oneline'
alias gmergetool='git mergetool'
alias gstash='git stash'
alias gspop='git stash pop'
alias gtag='git tag'
alias gcherrypick='git cherry-pick'

# ワークツリーで変更済みのファイルにタグをつけてコミットする
function gtag_commit
  git tag -a $argv[1] -m $argv[1] -a
end

# lazygit
alias l='lazygit'

# nvim
alias v='nvim'

# raycast
alias raycast='open raycast://'

# ripgrep
# hidden files to be searched by default
# gitディレクトリは検索対象から除外
alias rg="rg --hidden --g '!.git'"

# rgでgrepした結果をdeltaで見やすく表示する
function rgdelta
  rg --line-number --no-heading --color=always $argv \
  | delta --paging=auto
end

# terraform
alias tinit='terraform init'
alias tplan='terraform plan'
alias tapply='terraform apply'
alias tstate='terraform state'
alias tstatels='terraform state list'
alias tstatecat='terraform state show'
alias tplangenerate='terraform plan -generate-config-out=tmp.tf'

# tftui
alias tui='tftui'

# tig
alias tiga='tig --all'

# tmux
alias tmuxRestart='tmux attach'
alias tmuxKillAll='tmux kill-server'

# volta

# インストールしたNode.jsを削除する
function remove_node_for_volta
  set package $argv[1]
  set dir "$HOME/.volta/tools/image/node/$package/"

  if test -d $dir
    rm -rf $dir
    if test $status -eq 0
      echo "Successfully removed $package"
    else
      echo "Failed to remove $package"
    end
  else
    echo "Not found $package"
  end
end

# wezterm
alias imgcat='wezterm imgcat'

# yazi
# https://yazi-rs.github.io/docs/quick-start#shell-wrapper
function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  rm -f -- "$tmp"
end

# zoxide
zoxide init fish | source

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

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# direnv
# https://github.com/direnv/direnv/blob/master/docs/hook.md#fish
direnv hook fish | source

# starship
starship init fish | source

# Added by `rbenv init` on Thu Jan  2 23:43:55 JST 2025
status --is-interactive; and rbenv init - --no-rehash fish | source

# NOTE: fishをnixで管理するように変更したら、fish起動時にNixの環境設定を有効にしないとnixコマンドが使えなくなったので足した。
if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end
