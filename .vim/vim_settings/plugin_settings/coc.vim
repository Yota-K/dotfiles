" ヒントを表示
" silent・・・コマンドラインへの出力を抑制する
" <C-u>hoge<cr>・・・特殊なキーのマッピング
" https://thinca.hatenablog.com/entry/20100205/1265307642
nnoremap <silent> <space>h :<C-u>call CocAction('doHover')<cr>
