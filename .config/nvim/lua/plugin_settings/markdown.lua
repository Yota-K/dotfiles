-- markdownを見やすくするプラグイン
return {
  "MeanderingProgrammer/render-markdown.nvim",
  name = "render-markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "RenderMarkdownToggle",
  ft = { "markdown" },
  keys = {
    { "<C-r>", mode = "n" },
  },
  config = function()
    vim.api.nvim_set_keymap("n", "<C-r>", "<cmd>RenderMarkdown toggle<CR>", { noremap = true, silent = true })
    require("render-markdown").setup({})
  end,
}
