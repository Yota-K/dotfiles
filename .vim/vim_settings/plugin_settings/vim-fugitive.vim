" ステータスバーにブランチの情報を表示
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" diffsplitを縦分割で表示 
set diffopt+=vertical

nnoremap <Space>g :Gdiffsplit<CR>
