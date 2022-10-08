require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'css',
    'fish',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'php',
    'scss',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml'
  },
  highlight = {
    enable = true,
  },
}
