#!/bin/sh
# WezTerm のタブに Claude の状態を出すためのユーザー変数 claude を設定する
# usage: tab-mark.sh [done|wait]  (引数なしでクリア)

p=$PPID
while [ "$p" -gt 1 ]; do
  t=$(ps -o tty= -p "$p" | tr -d ' ')
  [ "$t" != "??" ] && break
  p=$(ps -o ppid= -p "$p" | tr -d ' ')
done
[ -n "$t" ] && [ "$t" != "??" ] || exit 0

printf '\033]1337;SetUserVar=claude=%s\007' "$(printf '%s' "$1" | base64)" >"/dev/$t" 2>/dev/null
exit 0
