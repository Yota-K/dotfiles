local status, builtin = pcall(require, 'telescope.builtin')
if (not status) then return end

vim.keymap.set('n', 'ff', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true
  })
end)
-- vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
