-- formatter
return {
  "stevearc/conform.nvim",
  event = { "BufRead" },
  config = function()
    -- biomeとprettierのformatterが競合してしまうので、設定ファイルを確認してフォーマッターを切り替える
    local js_formatter = function()
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

      local has_eslint = vim.fs.find({
        -- https://eslint.org/docs/latest/use/configure/configuration-files
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.ts",
        "eslint.config.cjs",
        "eslint.config.mts",
        "eslint.config.cts",
        -- flat config以前のフォーマットも一応指定しておく
        -- https://eslint.org/docs/latest/use/configure/configuration-files-deprecated
        ".eslintrc.js",
        ".eslintrc.cjs",
        ".eslintrc.yaml",
        ".eslintrc.yml",
        ".eslintrc.json",
      }, { upward = true })[1]

      local has_biome_config = vim.fs.find({
        "biome.json",
        "biome.jsonc",
      }, { upward = true })[1]

      if has_prettier and has_eslint then
        return { "prettier", "eslint_d" }
      end

      if has_biome_config and has_eslint then
        -- Prettierの設定ファイルがなく、ESLintの設定ファイルが存在する場合は、フォーマッターとしてbiomeを利用する
        return { "biome", "eslint_d" }
      end

      if has_biome_config then
        return { "biome" }
      end

      return {}
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
      formatters = {
        biome = {
          command = "npx",
          -- biome check --write --unsafeでフォーマットする
          args = {
            "biome",
            "check",
            "--write",
            "--unsafe",
            "--stdin-file-path",
            "$FILENAME",
          },
          stdin = true,
          cwd = require("conform.util").root_file({ "biome.json", "biome.jsonc" }),
        },
      },
    })
  end,
}
