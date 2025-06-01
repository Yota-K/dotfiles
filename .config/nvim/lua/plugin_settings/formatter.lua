-- formatter
return {
  "stevearc/conform.nvim",
  event = { "BufRead" },
  config = function()
    -- biomeとprettierのformatterが競合してしまうので、有効になっているlspを確認してbiomeとprettierを切り替える
    local js_formatter = function(bufnr)
      local has_biome_lsp = vim.lsp.get_clients({
        bufnr = bufnr,
        name = "biome",
      })[1]

      -- 外部フォーマッタは使わず、LSP のフォーマットを使う
      if has_biome_lsp then
        return {}
      end

      local has_prettier = vim.fs.find({
        -- https://prettier.io/docs/en/configuration.html
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        ".prettierrc.cjs",
        ".prettierrc.toml",
        "prettier.config.js",
        "prettier.config.cjs",
      }, { upward = true })[1]

      -- prettierが設定されている場合は、eslint_dとprettierを使用する
      if has_prettier then
        return { "eslint_d", "prettier" }
      end

      return { "biome" }
    end
    -- 最初に利用可能なフォーマッタを実行する
    local web_formatter = { "biome", "prettier", stop_after_first = true }

    require("conform").setup({
      formatters_by_ft = {
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        vue = js_formatter,
        svelte = js_formatter,
        json = web_formatter,
        jsonc = web_formatter,
        css = web_formatter,
        scss = web_formatter,
        lua = { "stylua" },
        go = { "goimports", "gofmt" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        terraform = { "terraform_fmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}
