"----------------------------------------
" プラグインの設定
"----------------------------------------

" nerdtree
nnoremap <silent><C-n> :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeShowHidden=1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" vim-devicons
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" guifontを設定しないと文字化けになる。terminalで行ったフォントの設定と同様
" 公式サイトではLinuxとmacOSの設定が若干異なるが、Linuxの設定でもmacOSで問題なし
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

" indent-lightLine
set laststatus=2

let g:lightline = {
  \'colorscheme': 'molokai',
  \'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \},
  \'component_function': {
  \   'gitbranch': 'fugitive#head'
  \},
  \}

let g:indentLine_color_term = 17
let g:indentLine_char_list = ['|']
let g:indentLine_concealcursor = 'inc'

" ステータスバーにブランチの情報を表示
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" jsonのダブルクォーテーションを表示
autocmd Filetype json let g:indentLine_setConceal = 0

" vim-fugitive
" diffsplitを縦分割で表示 
set diffopt+=vertical

" coc
" ヒントを表示
" silent・・・コマンドラインへの出力を抑制する
" <C-u>hoge<cr>・・・特殊なキーのマッピング
" https://thinca.hatenablog.com/entry/20100205/1265307642
nnoremap <silent> <space>h :<C-u>call CocAction('doHover')<cr>

" emmet
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
\  'variables' : {
\    'lang' : "ja"
\  },
\  'html' : {
\    'indentation' : '  ',
\    'snippets' : {
\      'html:5': "<!DOCTYPE html>\n"
\        ."<html lang=\"${lang}\">\n"
\        ."<head>\n"
\        ."\t<meta charset=\"${charset}\">\n"
\        ."\t<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
\        ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
\        ."\t<title></title>\n"
\        ."</head>\n"
\        ."<body>\n\t${child}|\n</body>\n"
\        ."</html>",
\    }
\  }
\}

" ale
let g:ale_linters = {  
\   'javascript': ['eslint'],  
\}  

" caw.vim
nmap <C-z> <Plug>(caw:hatpos:toggle)
vmap <C-z> <Plug>(caw:hatpos:toggle)

" any-jump
" Custom ignore files
let g:any_jump_ignored_files = ['log', 'logs', 'images', 'imgs', 'img', 'node_modules', 'out', 'build', 'vendor', '.git', 'jquery-*.js', '*.bak', '*.map', '*.tmp', '*.temp']

" nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "M ✹",
    \ "Staged"    : "S ✚",
    \ "Untracked" : "U ✭",
    \ "Renamed"   : "R ➜",
    \ "Deleted"   : "D ✖",
    \ "Clean"     : "C ✔︎",
    \ "Unmerged"  : "═",
    \ "Dirty"     : "✗",
    \ "Unknown"   : "?"
    \ }
