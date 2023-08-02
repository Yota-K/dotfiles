--
--  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗ 
--  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--

-- package.path初期値にtheme.luaが存在するパスを追加する。
-- 環境変数としてデフォルトで指定されているパスは以下
--
-- /usr/local/share/lua/5.4/?.lua;
-- /usr/local/share/lua/5.4/?/init.lua;
-- /usr/local/lib/lua/5.4/?.lua;
-- /usr/local/lib/lua/5.4/?/init.lua;
-- ./?.lua;
-- ./?/init.lua

local module_path = ';'..os.getenv('HOME')..'/dotfiles/?.lua;'
package.path = package.path..module_path
local theme = require('theme')

require ('plugin_settings')
require ('base')
require ('functions')
require ('keymap')
require ('plugins')
require ('terminal')
require('nightfox').setup({
  groups = {
    nightfox = theme.theme_override_settings('nightfox'),
    carbonfox = theme.theme_override_settings('carbonfox'),
  },
})

-- 不要なデフォルトプラグインを無効化する
-- 参考: https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
vim.api.nvim_set_var('did_install_default_menus', 1)
vim.api.nvim_set_var('did_install_syntax_menu', 1)
vim.api.nvim_set_var('did_indent_on', 1)
vim.api.nvim_set_var('loaded_man', 1)
vim.api.nvim_set_var('loaded_matchit', 1)
vim.api.nvim_set_var('loaded_matchparen', 1)
vim.api.nvim_set_var('loaded_tarPlugin', 1)
vim.api.nvim_set_var('loaded_tutor_mode_plugin', 1)
vim.api.nvim_set_var('skip_loading_mswin', 1)

-- PackerCompileを自動実行
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

-- setup must be called before loading
vim.cmd('colorscheme nightfox')
-- vim.cmd('colorscheme carbonfox')

-- フローティングウィンドウを透明にする
vim.cmd([[
  " ターミナルでも True Color を使えるようにする。
  set termguicolors
  " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
  set pumblend=10
]])
