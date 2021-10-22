let g:indentLine_color_term = 17
let g:indentLine_char_list = ['|']
let g:indentLine_concealcursor = 'inc'
let g:indentLine_fileTypeExclude = ['coc-explorer']

" jsonのダブルクォーテーションを表示
autocmd Filetype json let g:indentLine_setConceal = 0
