-- markdownを見やすくするプラグイン
return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  -- tree-sitterの以下のparserに依存している
  -- markdown
  -- markdown_inline
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  cmd = "RenderMarkdownToggle",
  ft = { "markdown" },
  keys = {
    { "<C-r>", mode = "n" },
  },
  config = function()
    vim.api.nvim_set_keymap("n", "<C-r>", "<cmd>RenderMarkdownToggle<CR>", { noremap = true, silent = true })
    require("render-markdown").setup({})
  end,
}
