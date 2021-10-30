" コマンドを提供しておらず、ユーザーが好きなキーでマッピングするという使い方になるのでその設定
" https://github.com/skanehira/qfopen.vim
augroup qfopen-bufenter
  function! s:qfopen_keymap() abort
    nmap <buffer> a <Plug>(qfopen-action)
    nmap <buffer> <C-v> <Plug>(qfopen-open-vsplit)
    nmap <buffer> <C-x> <Plug>(qfopen-open-split)
    nmap <buffer> <C-t> <Plug>(qfopen-open-tab)
  endfunction
  au!
  au FileType qf call s:qfopen_keymap()
augroup END
