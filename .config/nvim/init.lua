--  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗ 
--  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝

require ('plugin_settings')
require ('base')
require ('functions')
require ('keymap')
require ('plugins')
require ('terminal')

vim.cmd[[
  " PackerCompileを自動実行
  " LuaでVimスクリプトを実行するためには、.vimファイルにコンパイルする必要がある
  autocmd BufWritePost plugins.lua PackerCompile

  " theme
  colorscheme PaperColor

  " タブの色を背景色と同化
  :hi TabLineFill ctermbg=212121
]]
