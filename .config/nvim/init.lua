--
--  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
--  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--

require("base")
require("functions")
require("keymap")
require("plugins")
require("terminal")

-- 不要なデフォルトプラグインを無効化する
-- 参考: https://zenn.dev/kawarimidoll/articles/8172a4c29a6653
vim.api.nvim_set_var("did_install_default_menus", 1)
vim.api.nvim_set_var("did_install_syntax_menu", 1)
vim.api.nvim_set_var("did_indent_on", 1)
vim.api.nvim_set_var("loaded_man", 1)
vim.api.nvim_set_var("loaded_matchit", 1)
vim.api.nvim_set_var("loaded_matchparen", 1)
vim.api.nvim_set_var("loaded_tarPlugin", 1)
vim.api.nvim_set_var("loaded_tutor_mode_plugin", 1)
vim.api.nvim_set_var("skip_loading_mswin", 1)

-- デフォルトテーマを使う時はここにかく
-- local plugin_module_path = ";" .. os.getenv("HOME") .. "/dotfiles/.config/nvim/plugin_settings/?.lua;"
-- package.path = package.path .. plugin_module_path
-- local theme = require("theme")
--
-- theme.theme_override_settings()
-- vim.cmd("colorscheme retrobox")

-- フローティングウィンドウを透明にする
vim.cmd([[
  " ターミナルでも True Color を使えるようにする。
  set termguicolors
  set pumblend=10
]])
