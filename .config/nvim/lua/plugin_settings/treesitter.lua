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
      "astro",
      "css",
      "fish",
      "go",
      "graphql",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "nix",
      "php",
      "prisma",
      "scss",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "vue",
      "yaml",
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
