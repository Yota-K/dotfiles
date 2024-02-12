-- linter, formatterの実行
return {
  "dense-analysis/ale",
  event = { "VimEnter" },
  dependencies = { "ckipp01/stylua-nvim" },
  config = function()
    -- neovimでaleの設定を使う場合に必要な宣言
    vim.g.ale_use_neovim_diagnostics_api = 1

    -- linterの設定
    vim.g.ale_linters = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
      vue = { "eslint" },
      svelte = { "eslint" },
      css = { "stylelint" },
      scss = { "stylelint" },
    }

    -- formatterの設定
    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      javascript = { "prettier", "eslint" },
      json = { "prettier", "eslint" },
      javascriptreact = { "prettier", "eslint" },
      typescript = { "prettier", "eslint" },
      typescriptreact = { "prettier", "eslint" },
      vue = { "prettier", "eslint" },
      svelte = { "prettier", "eslint" },
      css = { "prettier", "stylelint" },
      scss = { "prettier", "stylelint" },
      go = { "trim_whitespace", "remove_trailing_lines", "goimports", "gofmt" },
      lua = { "stylua" },
    }

    -- ファイル保存時に実行
    vim.g.ale_fix_on_save = 1

    -- ローカルの設定ファイルを考慮する
    vim.g.ale_javascript_prettier_use_local_config = 1
  end,
}
