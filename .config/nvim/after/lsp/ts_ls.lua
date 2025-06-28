---@type vim.lsp.Config
return {
  -- package.jsonがある時はNode.jsを使っているとみなす
  root_markers = {
    'package.json',
  },
  workspace_required = true,
}
