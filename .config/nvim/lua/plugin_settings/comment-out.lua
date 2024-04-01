-- コメントアウトを効率化
return {
  "terrortylor/nvim-comment",
  keys = {
    { "<C-z>", mode = "n" },
    { "<C-z>", mode = "v" },
  },
  config = function()
    local comment = require("nvim_comment")

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
  end,
}
