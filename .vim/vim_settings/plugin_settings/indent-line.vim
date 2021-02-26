set laststatus=2

let g:indentLine_color_term = 17
let g:indentLine_char_list = ['|']
let g:indentLine_concealcursor = 'inc'

" jsonのダブルクォーテーションを表示
autocmd Filetype json let g:indentLine_setConceal = 0
