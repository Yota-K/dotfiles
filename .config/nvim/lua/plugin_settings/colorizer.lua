-- カラーコードの色を見えやすいように表示
return {
  "brenoprata10/nvim-highlight-colors",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    -- Ensure termguicolors is enabled if not already
    vim.opt.termguicolors = true

    require("nvim-highlight-colors").setup({})
  end,
}
