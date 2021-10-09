"----------------------------------------
" テーマ
"----------------------------------------
 
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

" 背景色tron256用（上書き）
autocmd ColorScheme * highlight Normal ctermbg=0

" 行の背景色（上書き）
autocmd ColorScheme * highlight lineNr ctermbg=0

" 行数の数字が表示されてる部分の幅
set numberwidth=6

syntax enable
" colorscheme tron256
colorscheme pablo
