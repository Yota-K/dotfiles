-- NOTE
--
-- 補完の移動
-- control + n 下に移動
-- control + p 上に移動
-- 
-- silent・・・コマンドラインへの出力を抑制する
-- <C-u>hoge<cr>・・・特殊なキーのマッピング
-- https://thinca.hatenablog.com/entry/20100205/1265307642
local keyset = vim.api.nvim_set_keymap

-- ヒントを表示
keyset('n', '<space>h', ':<C-u>call CocAction("doHover")<cr>', {
  silent = true
})

-- CocListを表示
keyset('n', '<space>l', ':CocList<cr>', {
  silent = true
})

-- cocで表示されるフローティングウィンドウのスクロールのキーマッピング
-- issues: https://github.com/neoclide/coc.nvim/issues/609
local opts = { silent = true, nowait = true, expr = true }

keyset('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
