-- linter
return {
  "mfussenegger/nvim-lint",
  event = { "BufRead" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d", "biomejs" },
      javascriptreact = { "eslint_d", "biomejs" },
      typescript = { "eslint_d", "biomejs", "cspell" },
      typescriptreact = { "eslint_d", "biomejs", "cspell" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      markdown = { "cspell" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
