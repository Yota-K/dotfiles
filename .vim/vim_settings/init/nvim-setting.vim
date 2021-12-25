"----------------------------------------
" Neovimの設定
"----------------------------------------

if has('nvim')
  " TerminalをVSCodeのように現在のウィンドウの下に開く
  autocmd TermOpen * startinsert

  " 常にインサートモードでTerminalを開く
  command! -nargs=* T sp | wincmd j | resize 20 | terminal <args>

  " インサートモードからの離脱をescキーにマッピング
  tnoremap<Esc> <C-\><C-n>

  " ファイラーのアイコンフォントの表示が崩れてしまうのを防ぐ
  if exists('&ambw')
    set ambiwidth=single
  endif
else
"----------------------------------------
" 普通のVimのみに適用したい設定はここに書く
"----------------------------------------

  " 記号などで字が潰れるのを防ぐ
  set ambiwidth=double
endif
