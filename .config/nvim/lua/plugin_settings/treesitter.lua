local status, nvim_treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

nvim_treesitter_configs.setup {
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
