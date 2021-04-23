"----------------------------------------
" テーマ
"----------------------------------------

" シンタックスハイライト (上書き)
autocmd ColorScheme * highlight javascriptArrowFuncArg ctermfg=13
autocmd ColorScheme * highlight javascriptImport ctermfg=226 
autocmd ColorScheme * highlight javascriptString ctermfg=249

" floating window（上書き）
autocmd ColorScheme * highlight Pmenu ctermbg=234
autocmd ColorScheme * highlight PmenuSel ctermbg=cyan
autocmd ColorScheme * highlight PmenuThumb ctermfg=darkcyan guibg=darkcyan
autocmd ColorScheme * highlight PmenuSbar ctermbg=white

" gitの差分を表示する際の色（上書き）
autocmd ColorScheme * highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
autocmd ColorScheme * highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
autocmd ColorScheme * highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
autocmd ColorScheme * highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" ファイラーのアイコンの色（上書き）
autocmd ColorScheme * highlight NERDTreeOpenable ctermfg=75
autocmd ColorScheme * highlight NERDTreeClosable ctermfg=75
autocmd ColorScheme * highlight nerdtreeExactMatchFolder_node_modules ctermfg=34

" 行数の数字が表示されてる部分の幅
set numberwidth=4

syntax enable
colorscheme tron256
" colorscheme darkblue_custom
" colorscheme slate
