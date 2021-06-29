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

" Change background color of status bar only (to make it match the background of the terminal)
"ステータスバーの背景色をターミナルの色と合わせる
let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle
