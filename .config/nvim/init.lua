--
--  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗ 
--  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--

require ('plugin_settings')
require ('base')
require ('functions')
require ('keymap')
require ('plugins')
require ('terminal')

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

-- フローティングウィンドウを透明にする
vim.cmd([[
  " ターミナルでも True Color を使えるようにする。
  set termguicolors
  " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
  set pumblend=10
]])
