local keymap = vim.api.nvim_set_keymap

keymap('n', '<C-z>', '<Plug>(caw:hatpos:toggle)', {})
keymap('v', '<C-z>', '<Plug>(caw:hatpos:toggle)', {})
