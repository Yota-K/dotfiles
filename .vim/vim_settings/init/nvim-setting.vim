"----------------------------------------
" Neovimの設定
"----------------------------------------

if has('nvim')
  " TerminalをVSCodeのように現在のウィンドウの下に開く
  autocmd TermOpen * startinsert

  " 常にインサートモードでTerminalを開く（水平分割）
  command! -nargs=* T sp | wincmd j | resize 20 | terminal <args>
  nnoremap T :T<CR>

  " 常にインサートモードでTerminalを開く（垂直分割）
  command! -nargs=* TS vs | wincmd j | resize 100 | terminal <args>
  nnoremap TS :TS<CR>

  " インサートモードからの離脱をspace + qにマッピング
  tnoremap<Space>q <C-\><C-n>

  " ファイラーのアイコンフォントの表示が崩れてしまうのを防ぐ
  if exists('&ambw')
    set ambiwidth=single
  endif
endif
