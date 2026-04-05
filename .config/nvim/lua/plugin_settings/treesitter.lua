-- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = "VimEnter",
  build = ":TSUpdate",
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    local ensure_installed = {
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
      "markdown",
      "markdown_inline",
      "nix",
    }
    local already_installed = require("nvim-treesitter").get_installed()
    local parsers_to_install = vim.iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
      end)
      :totable()
    if #parsers_to_install > 0 then
      require("nvim-treesitter").install(parsers_to_install)
    end
  end,
}
