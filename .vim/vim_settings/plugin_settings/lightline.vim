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
