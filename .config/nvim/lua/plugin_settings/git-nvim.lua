local status, git = pcall(require, 'git')
if (not status) then return end

git.setup({
  -- `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
  default_mappings = true,

  keymaps = {
    diff = "<Space>g",
  },
})
