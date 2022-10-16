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

-- PackerCompileを自動実行
-- LuaでVimスクリプトを実行するためには、.vimファイルにコンパイルする必要がある
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-- タブの色を背景色と同化
vim.cmd [[:hi TabLineFill ctermbg=212121]]
