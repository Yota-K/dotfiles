-- linter
return {
  "mfussenegger/nvim-lint",
  event = { "BufRead" },
  config = function()
    local lint = require("lint")

    -- コマンドが存在するかチェック
    local function executable(cmd)
      return vim.fn.executable(cmd) == 1
    end

    -- linterの実行をスキップする条件
    -- conflictファイルやバックアップファイルの場合はスキップする
    local function should_skip_lint()
      if vim.bo.buftype ~= "" then return true end
      local name = vim.api.nvim_buf_get_name(0)
      return name == ""
          or name:match("_BACKUP_")
          or name:match("_BASE_")
          or name:match("_LOCAL_")
          or name:match("_REMOTE_")
    end

    local eslint_config = {
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.ts",
      "eslint.config.cjs",
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

    local function has_config(config_files)
      local bufname = vim.api.nvim_buf_get_name(0)
      local bufdir = vim.fn.fnamemodify(bufname, ":h")
      local found = vim.fs.find(config_files, { path = bufdir, upward = true, limit = 1 })
      return #found > 0
    end

    local function get_js_linters()
      local has_eslint = has_config(eslint_config)
      local has_biome = has_config(biome_config)

      if has_eslint and executable("eslint_d") then
        return { "eslint_d" }
      end

      if has_biome and executable("biome") then
        return { "biomejs" }
      end

      return {}
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        if should_skip_lint() then
          return
        end

        local ft = vim.bo.filetype
        local js_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" }

        if vim.tbl_contains(js_filetypes, ft) then
          local linters = get_js_linters()
          if vim.tbl_contains({ "typescript", "typescriptreact" }, ft) and executable("cspell") then
            table.insert(linters, "cspell")
          end
          lint.try_lint(linters)
        elseif ft == "lua" or ft == "markdown" then
          if executable("cspell") then
            lint.try_lint({ "cspell" })
          end
        end
      end,
    })
  end,
}
