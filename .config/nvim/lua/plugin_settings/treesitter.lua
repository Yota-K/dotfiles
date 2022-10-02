require('nvim-treesitter.configs').setup {
  ensure_installed = { 'css', 'fish', 'go', 'html', 'javascript', 'scss', 'php', 'tsx', 'vim', 'vue', 'yaml' },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { 'ruby' },  -- list of language that will be disabled
  },
}
