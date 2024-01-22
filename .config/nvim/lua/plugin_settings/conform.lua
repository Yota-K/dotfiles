require("conform").setup({
  formatters_by_ft = {
    javascript = { { "prettier" } },
    javascriptreact = { { "prettier" } },
    typescript = { { "prettier" } },
    typescriptreact = { { "prettier" } },
    vue = { { "prettier" } },
    svelte = { { "prettier" } },
    astro = { { "prettier" } },
    css = { { "stylelint", "prettier" } },
    scss = { { "stylelint", "prettier" } },
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})
