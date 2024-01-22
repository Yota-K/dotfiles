require("lint").linters_by_ft = {
  javascript = { "eslint_d", "cspell" },
  javascriptreact = { "eslint_d", "cspell" },
  typescript = { "eslint_d", "cspell" },
  typescriptreact = { "eslint_d", "cspell" },
  vue = { "eslint_d", "cspell" },
  svelte = { "eslint_d", "cspell" },
  json = { "eslint_d", "cspell" },
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
