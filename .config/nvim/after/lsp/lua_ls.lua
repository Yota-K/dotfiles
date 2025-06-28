---@type vim.lsp.Config
return {
  -- LuaのLSPの設定をオーバーライドする
  -- 参考: https://github.com/cpdean/cpd.dotfiles/blob/7da9ac7f64857cb5139f6623bd8ca0eaf63ddd5f/config/nvim/lua/cpdean_config/nvim-lsp.lua#L326-L375
  -- Define configs for Mason-managed servers using vim.lsp.config()
  settings = {
    Lua = {
      diagnostics = { globals = { "vim", }, },
    },
  },
  workspace_required = true,
}
