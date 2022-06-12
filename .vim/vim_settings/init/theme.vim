"----------------------------------------
" テーマ
"----------------------------------------
 
" floating window（上書き）
autocmd ColorScheme * highlight Pmenu ctermbg=234
autocmd ColorScheme * highlight PmenuSel ctermbg=cyan
autocmd ColorScheme * highlight PmenuThumb ctermbg=darkcyan
autocmd ColorScheme * highlight PmenuSbar ctermbg=white
 
" gitの差分を表示する際の色（上書き）
autocmd ColorScheme * highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
autocmd ColorScheme * highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
autocmd ColorScheme * highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
autocmd ColorScheme * highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" 背景色 tron256用（上書き）
" autocmd ColorScheme * highlight Normal ctermbg=0

" 背景色 dracula用（上書き）
" autocmd ColorScheme * highlight Normal ctermbg=0
autocmd ColorScheme * highlight Normal ctermbg=282a36

" コメントアウトの色 pablo用（上書き）
autocmd ColorScheme * highlight Comment ctermfg=250

" サイドバーの左端の色（上書き）
" https://github.com/lambdalisue/fern.vim/issues/342
autocmd ColorScheme * highlight SignColumn ctermbg=none

" 行数の数字が表示されてる部分の幅
set numberwidth=6

syntax enable

autocmd Filetype fern :IndentLinesDisable

colorscheme dracula
" colorscheme pablo
" colorscheme tron256
