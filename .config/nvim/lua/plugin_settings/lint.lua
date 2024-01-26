-- lintの実行
return {
  "mfussenegger/nvim-lint",
  event = { "VimEnter" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "cspell" },
      javascriptreact = { "cspell" },
      typescript = { "cspell" },
      typescriptreact = { "cspell" },
      vue = { "cspell" },
      svelte = { "cspell" },
      json = { "cspell" },
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
