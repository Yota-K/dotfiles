---@type vim.lsp.Config
return {
  -- package.jsonがある時はNode.jsを使っているとみなす
  root_markers = {
    'package.json',
  },
  workspace_required = true,
  before_init = function(_, config)
    -- typescript 7系はtsserver.jsを同梱しないため、miseで管理しているtypescript(6系)を使う
    local lib = vim.fs.joinpath(config.root_dir, 'node_modules/typescript/lib')
    if not vim.uv.fs_stat(lib) or vim.uv.fs_stat(lib .. '/tsserver.js') then
      return
    end

    local mise_dir = vim.fn.system({ 'mise', 'where', 'npm:typescript' }):gsub('\n$', '')
    if vim.v.shell_error == 0 and mise_dir ~= '' then
      config.init_options = config.init_options or {}
      config.init_options.tsserver = { path = mise_dir .. '/node_modules/typescript/lib/tsserver.js' }
    end
  end,
}
