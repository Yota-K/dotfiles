"----------------------------------------
" 初期設定
"----------------------------------------

set encoding=UTF-8

set t_Co=256

" 全角スペースにシンタックスハイライトをかける
augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
