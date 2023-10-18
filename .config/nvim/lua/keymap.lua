-- keymap
local keymap = vim.api.nvim_set_keymap

keymap("i", "(<Enter>", "()<Left>", { silent = true })
keymap("i", "{<Enter>", "{}<Left>", { silent = true })
keymap("i", "[<Enter>", "[]<Left>", { silent = true })
keymap("i", '"<Enter>', '""<Left>', { silent = true })
keymap("i", "'<Enter>", "''<Left>", { silent = true })
keymap("i", "`<Enter>", "``<Left>", { silent = true })
keymap("i", "<C-s>", "\\", { silent = true })

keymap("n", "j", "gj", { noremap = true })
keymap("n", "k", "gk", { noremap = true })
keymap("n", "+", "<C-a>", { noremap = true })
keymap("n", "-", "<C-x>", { noremap = true })
keymap("n", "<Esc>", ":nohlsearch<CR>", { noremap = true })
keymap("n", "<Left>", "<Nop>", { noremap = true })
keymap("n", "<Down>", "<Nop>", { noremap = true })
keymap("n", "<Up>", "<Nop>", { noremap = true })
keymap("n", "<Right>", "<Nop>", { noremap = true })
keymap("n", "<Space>n", ":set invnumber<CR>", { noremap = true })
