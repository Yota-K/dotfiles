require ('plugin_settings')
require ('base')
require ('keymap')
require ('plugins')
require ('terminal')

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

-- theme
vim.cmd 'colorscheme PaperColor'
