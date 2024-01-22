require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  vue = { "eslint_d" },
  svelte = { "eslint_d" },
}

-- 以下のイベントが発生した時にLintを実行する
--
-- - バッファ全体をファイルに書き込んだ後
-- - 新しいバッファの編集を始めたとき
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
