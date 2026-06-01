-- カラーコードの色を見えやすいように表示
return {
  "Yota-K/nvim-highlight-colors", -- TODO: PR (https://github.com/brenoprata10/nvim-highlight-colors/issues/179) マージ後に upstream に戻す
  commit = "08407be4943fb5726bd93c0a8cf36243c9f60c89",
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
