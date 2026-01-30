-- linter
return {
  "mfussenegger/nvim-lint",
  event = { "BufRead" },
  config = function()
    local lint = require("lint")

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

      if has_eslint then
        return { "eslint_d" }
      end

      if has_biome then
        return { "biomejs" }
      end

      return {}
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        local ft = vim.bo.filetype
        local js_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" }

        if vim.tbl_contains(js_filetypes, ft) then
          local linters = get_js_linters()
          if vim.tbl_contains({ "typescript", "typescriptreact" }, ft) then
            table.insert(linters, "cspell")
          end
          lint.try_lint(linters)
        elseif ft == "lua" or ft == "markdown" then
          lint.try_lint({ "cspell" })
        end
      end,
    })
  end,
}
