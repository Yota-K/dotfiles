# プロンプトの表示をカスタマイズ
# https://qiita.com/najayama/items/553329c242edc434b155#
# https://qiita.com/mom0tomo/items/b593c0e98c1eea70a114

# 現在のディレクトリを表示
function _prompt_dir
  printf '\uf07b  %s' (prompt_pwd)
end

function _git_status
  # ワークツリーの中であればtrueが返ってくる
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    # Git
    set last_status $status
    printf ' \ue65b %s ' (__fish_git_prompt)
    set_color normal
  end
end

# メインで表示されるやつ
function fish_prompt
  _prompt_dir
  _git_status

  printf '\n'

  # SSH のプロンプトでホスト名に色を付ける
  test $SSH_TTY
  and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
  test $USER = 'root'
  and echo (set_color red)"#"

  # Main
  echo -n (set_color cyan) (set_color f55f17)'❯'(set_color 1afea3)'❯'(set_color 20d6fd)'❯ '
end
