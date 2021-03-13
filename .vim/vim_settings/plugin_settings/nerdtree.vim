" 0 表示する
" 1 表示しない
nnoremap <silent><C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let g:webdevicons_conceal_nerdtree_brackets = 1
let NERDTreeChDirMode=1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" ディレクトリの横の/を非表示
augroup nerdtreehidecwd
  autocmd!
  autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
