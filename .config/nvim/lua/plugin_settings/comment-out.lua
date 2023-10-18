local status, comment = pcall(require, "nvim_comment")
if not status then
	return
end

comment.setup()

local keyset = vim.api.nvim_set_keymap

keyset("n", "<C-z>", ":CommentToggle<CR>", { noremap = true })
keyset("v", "<C-z>", ":CommentToggle<CR>", { noremap = true })
