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
    local js_formatter = function()
      local root_prettier = require("conform.util").root_file(prettier_config)
      local root_eslint = require("conform.util").root_file(eslint_config)
      local root_biome = require("conform.util").root_file(biome_config)

      local has_prettier = root_prettier ~= nil
      local has_eslint = root_eslint ~= nil
      local has_biome_config = root_biome ~= nil

      if has_prettier and has_eslint then
        return { "eslint_d", "prettier" }
      end

      if has_biome_config and has_eslint then
        return { "eslint_d", "biome" }
      end

      if has_biome_config then
        return { "biome" }
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
      },
      format_on_save = {
        -- モノレポ構成の場合、ルートから深い階層にあるファイルに対してフォーマッターを実行すると、タイムアウトエラーで落ちるため、長めに5秒で設定している
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      -- Formatterの動作をカスタマイズする
      formatters = {
        biome = {
          command = "npx",
          -- biome check --write --unsafe でフォーマットする
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
          command = "npx",
          -- Mason経由でインストールしたeslint_dを使用してフォーマットする
          -- @see: https://github.com/mantoni/eslint_d.js/
          args = {
            "eslint_d",
            "--fix-to-stdout",
            "--stdin",
            "--stdin-filename",
            "$FILENAME",
          },
          stdin = true,
          cwd = require("conform.util").root_file(eslint_config),
        },
      },
    })
  end,
}
