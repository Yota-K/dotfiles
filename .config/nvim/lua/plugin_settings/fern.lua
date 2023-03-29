vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -reveal=% -drawer -toggle<CR>', { noremap = true, silent = true })

vim.cmd([[
  let g:fern#renderer = 'nvim-web-devicons'
  let g:fern#default_hidden = 1
  let g:fern#drawer_width = 50
  let g:fern_disable_startup_warnings = 1

  function! s:init_fern() abort
    " Write custom code here
    
    nmap <buffer> i <Plug>(fern-action-open:split)
    nmap <buffer> s <Plug>(fern-action-open:vsplit)

    nmap <buffer> b <Plug>(fern-action-new-file)
    nmap <buffer> B <Plug>(fern-action-new-dir)
    nmap <buffer> r <Plug>(fern-action-rename)

    nmap <buffer> d <Plug>(fern-action-trash)
    nmap <buffer> D <Plug>(fern-action-remove)

    nmap <buffer> dd <Plug>(fern-action-move)
    nmap <buffer> y <Plug>(fern-action-clipboard-copy)
    nmap <buffer> p <Plug>(fern-action-clipboard-paste)

    nmap <buffer> R
      \ <Plug>(fern-action-reload)
      \ <Plug>(fern-action-reload:cursor)

    nmap <buffer> / <Plug>(fern-action-grep=)
  endfunction

  augroup fern-custom
    autocmd! *
    autocmd FileType fern call s:init_fern()
  augroup END

  " アイコンに色をつける
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
]])
