local keymap = vim.api.nvim_set_keymap

local silent = { silent = true }
keymap("i", "(<Enter>", "()<Left>", silent)
keymap("i", "{<Enter>", "{}<Left>", silent)
keymap("i", "[<Enter>", "[]<Left>", silent)
keymap("i", '"<Enter>', '""<Left>', silent)
keymap("i", "'<Enter>", "''<Left>", silent)
keymap("i", "`<Enter>", "``<Left>", silent)
keymap("i", "<C-s>", "\\", silent)

local noremap = { noremap = true }
keymap("n", "j", "gj", noremap)
keymap("n", "k", "gk", noremap)
keymap("n", "+", "<C-a>", noremap)
keymap("n", "-", "<C-x>", noremap)
keymap("n", "<Esc>", ":nohlsearch<CR>", noremap)
keymap("n", "<Left>", "<Nop>", noremap)
keymap("n", "<Down>", "<Nop>", noremap)
keymap("n", "<Up>", "<Nop>", noremap)
keymap("n", "<Right>", "<Nop>", noremap)
keymap("n", "<Space>n", ":set invnumber<CR>", noremap)
