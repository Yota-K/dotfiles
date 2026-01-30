-- formatter
return {
  "stevearc/conform.nvim",
  event = { "BufRead" },
  config = function()
    local prettier_config = {
      -- https://prettier.io/docs/en/configuration.html
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.yml",
      ".prettierrc.yaml",
      ".prettierrc.json5",
      ".prettierrc.js",
      ".prettierrc.cjs",
      ".prettierrc.mjs",
      ".prettierrc.toml",
      "prettier.config.js",
      "prettier.config.cjs",
    }
    local eslint_config = {
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
    }
    local biome_config = {
      "biome.json",
      "biome.jsonc",
    }

    -- biomeとprettierのformatterが競合してしまうので、設定ファイルを確認してフォーマッターを切り替える
    -- 複数のフォーマッタが指定されている場合は、順番にフォーマッターを実行する挙動になる
    -- @see: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
    local function has_config(bufnr, config_files)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local bufdir = vim.fn.fnamemodify(bufname, ":h")
      local found = vim.fs.find(config_files, { path = bufdir, upward = true, limit = 1 })
      return #found > 0
    end

    local js_formatter = function(bufnr)
      local has_prettier = has_config(bufnr, prettier_config)
      local has_eslint = has_config(bufnr, eslint_config)
      local has_biome_config = has_config(bufnr, biome_config)

      if has_prettier and has_eslint then
        return { "eslint_d", "prettier" }
      end

      if has_biome_config and has_eslint then
        return { "eslint_d", "biome_format" }
      end

      if has_biome_config then
        return { "biome_check" }
      end

      return {}
    end

    require("conform").setup({
      formatters_by_ft = {
        javascript = js_formatter,
        typescript = js_formatter,
        javascriptreact = js_formatter,
        typescriptreact = js_formatter,
        vue = js_formatter,
        svelte = js_formatter,
        go = { "gofumpt" },
      },
      format_on_save = {
        -- モノレポ構成の場合、ルートから深い階層にあるファイルに対してフォーマッターを実行すると、タイムアウトエラーで落ちるため、長めに5秒で設定している
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      -- Formatterの動作をカスタマイズする
      formatters = {
        prettier = {
          command = "npx",
          args = {
            "prettier",
            "--stdin-filepath",
            "$FILENAME",
          },
          stdin = true,
          cwd = require("conform.util").root_file(prettier_config),
        },
        biome_format = {
          command = "npx",
          args = {
            "biome",
            "format",
            "--stdin-file-path",
            "$FILENAME",
          },
          stdin = true,
          cwd = require("conform.util").root_file(biome_config),
        },
        biome_check = {
          command = "npx",
          args = {
            "biome",
            "check",
            "--write",
            "--unsafe",
            "--stdin-file-path",
            "$FILENAME",
          },
          stdin = true,
          cwd = require("conform.util").root_file(biome_config),
        },
        eslint_d = {
          cwd = require("conform.util").root_file(eslint_config),
        },
      },
    })
  end,
}
