-- markdownを見やすくするプラグイン
return {
  "MeanderingProgrammer/markdown.nvim",
  ft = { "markdown" },
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  -- tree-sitterの以下のparserに依存している
  -- markdown
  -- markdown_inline
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup({})
  end,
}
