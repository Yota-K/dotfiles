-- linter, formatterの実行
return {
  "dense-analysis/ale",
  event = { "BufRead" },
  dependencies = { "ckipp01/stylua-nvim" },
  config = function()
    -- neovimでaleの設定を使う場合に必要な宣言
    vim.g.ale_use_neovim_diagnostics_api = 1

    -- linterの設定
    vim.g.ale_linters = {
      javascript = { "eslint", "biome" },
      javascriptreact = { "eslint", "biome" },
      typescript = { "eslint", "cspell", "biome" },
      typescriptreact = { "eslint", "cspell", "biome" },
      vue = { "eslint" },
      svelte = { "eslint" },
      css = { "stylelint" },
      scss = { "stylelint" },
    }

    -- formatterの設定
    vim.g.ale_fixers = {
      ["*"] = { "remove_trailing_lines", "trim_whitespace" },
      ["rust"] = { "rustfmt" },
      javascript = { "prettier", "biome", "eslint" },
      json = { "prettier", "biome", "eslint" },
      javascriptreact = { "prettier", "biome", "eslint" },
      typescript = { "prettier", "biome", "eslint" },
      typescriptreact = { "prettier", "biome", "eslint" },
      vue = { "prettier", "biome", "eslint" },
      svelte = { "prettier", "biome", "eslint" },
      css = { "prettier", "stylelint" },
      scss = { "prettier", "stylelint" },
      go = { "trim_whitespace", "remove_trailing_lines", "goimports", "gofmt" },
      lua = { "stylua" },
      terraform = { "terraform" },
    }

    -- ファイル保存時に実行
    vim.g.ale_fix_on_save = 1

    -- ローカルの設定ファイルを考慮する
    vim.g.ale_javascript_prettier_use_local_config = 1
  end,
}
