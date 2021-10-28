let g:lightline = {
  \'colorscheme': 'darcula',
  \'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \},
  \'component_function': {
  \   'gitbranch': 'fugitive#head'
  \},
  \'tab_component_function': {
  \  'tabnum': 'LightlineWebDevIcons',
  \},
  \}

" Change background color of status bar only (to make it match the background of the terminal)
" ステータスバーの背景色をターミナルの色と合わせる
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

" タブに表示するアイコンをタブページ内のバッファに登録されているファイルから取得する
function! LightlineWebDevIcons(n)
  let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  " アイコンを表すフォント文字を返すvim-deviconsの関数
  " https://github.com/ryanoasis/vim-devicons/blob/4d14cb82cf7381c2f8eca284d1a757faaa73b159/DEVELOPER.md
  return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction
