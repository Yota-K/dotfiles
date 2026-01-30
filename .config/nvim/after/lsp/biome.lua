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

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local bufdir = vim.fn.fnamemodify(bufname, ":h")

    local has_eslint = #vim.fs.find(eslint_config, { path = bufdir, upward = true, limit = 1 }) > 0

    -- ESLintの設定ファイルが見つかった場合はBiomesの設定を無視することで、linterの競合を避ける
    if has_eslint then
      return
    end

    local biome_configs = { "biome.json", "biome.jsonc" }
    local found = vim.fs.find(biome_configs, { path = bufdir, upward = true, limit = 1 })
    if #found > 0 then
      on_dir(vim.fn.fnamemodify(found[1], ":h"))
    end
  end,
}
