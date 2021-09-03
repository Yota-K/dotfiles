" ヒントを表示
" silent・・・コマンドラインへの出力を抑制する
" <C-u>hoge<cr>・・・特殊なキーのマッピング
" https://thinca.hatenablog.com/entry/20100205/1265307642
nnoremap <silent> <space>h :<C-u>call CocAction('doHover')<cr>

" cocで表示されるフローティングウィンドウのスクロールのキーマッピング
" issues: https://github.com/neoclide/coc.nvim/issues/609
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

nnoremap <silent> <space>l :CocList<CR>
