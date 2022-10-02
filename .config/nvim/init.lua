 --  ___      ___ ___  _____ ______   ________  ________     
 -- |\  \    /  /|\  \|\   _ \  _   \|\   __  \|\   ____\    
 -- \ \  \  /  / | \  \ \  \\\__\ \  \ \  \|\  \ \  \___|    
 --  \ \  \/  / / \ \  \ \  \\|__| \  \ \   _  _\ \  \       
 --   \ \    / /   \ \  \ \  \    \ \  \ \  \\  \\ \  \____  
 --    \ \__/ /     \ \__\ \__\    \ \__\ \__\\ _\\ \_______\
 --     \|__|/       \|__|\|__|     \|__|\|__|\|__|\|_______|

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

  " タブの背景色を同化
  :hi TabLineFill ctermbg=212121
]]
