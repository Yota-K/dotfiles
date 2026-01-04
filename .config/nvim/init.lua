--
--  ██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
--  ██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
--  ██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
--  ██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
--  ██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
--  ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--

-- ログの保存先をtmpに変更
vim.env.XDG_STATE_HOME = '/tmp'

require("base")
require("functions")
require("keymap")
require("plugins")
require("tabline")
require("terminal")

-- フローティングウィンドウを透明にする
vim.cmd([[
  " ターミナルでも True Color を使えるようにする。
  set termguicolors
  set pumblend=20
]])
