---@type vim.lsp.Config
return {
  root_markers = {
    'deno.json',
    'deno.jsonc',
    'deps.ts',
  },
  workspace_required = true,
}
