local status, comment = pcall(require, "nvim_comment")
if not status then
  return
end

comment.setup({
  hook = function()
    -- ReactやVueのビュー部分でもコメントアウトをできるようにする
    --https://github.com/terrortylor/nvim-comment/issues/6
    -- They can do anything here, e.g.:
    require("ts_context_commentstring.internal").update_commentstring()
  end,
})

local keyset = vim.api.nvim_set_keymap

keyset("n", "<C-z>", ":CommentToggle<CR>", { noremap = true })
keyset("v", "<C-z>", ":CommentToggle<CR>", { noremap = true })
