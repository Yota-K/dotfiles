local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.setup {}

local keyset = vim.keymap.set

keyset('n', 'ff', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true
  })
end)
-- vim.keymap.set('n', 'fg', builtin.live_grep, {})
keyset('n', 'fb', builtin.buffers, {})
keyset('n', 'fh', builtin.help_tags, {})
