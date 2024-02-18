-- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "VimEnter",
  build = ":TSUpdate",
  config = function()
    local nvim_treesitter_configs = require("nvim-treesitter.configs")

    nvim_treesitter_configs.setup({
      ensure_installed = {
        "css",
        "fish",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "php",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
        "graphql",
        "prisma",
        "astro",
      },
      ignore_install = {},
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      modules = {},
    })
  end,
}
