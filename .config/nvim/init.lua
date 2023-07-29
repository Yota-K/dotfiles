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
require('nightfox').setup({
  groups = {
    nightfox = {
      -- 補完メニューのホバーしたときの色
      CocMenuSel = { bg = '#73daca', fg = 'bg0'},
      -- 補完メニューのスクロールバーの色
      PmenuThumb = { bg = 'white'},
      -- 境界線の色
      VertSplit = { fg = '#6fc3df' },
      -- タブの色を背景色と同化させる
      TabLineFill = { bg = '#172331'},
    },
    carbonfox = {
      -- coc.nvim
      -- フローティングウィンドウの色
      CocFloating = { bg = '#002b36' },
      -- nvim lsp
      Pmenu = { bg = '#002b36' },
      NormalFloat = { bg = '#002b36' },
      -- 選択時の色: 視認性重視
      Visual = { fg = 'white', bg = '#8080ff'  },
      PmenuThumb = { bg = 'white'},
      VertSplit = { fg = '#6fc3df' },
      TabLineFill = { bg = '#161616'}
    },
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
-- vim.cmd("colorscheme nightfox")
vim.cmd('colorscheme carbonfox')

-- フローティングウィンドウを透明にする
vim.cmd([[
  " ターミナルでも True Color を使えるようにする。
  set termguicolors
  " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
  set pumblend=10
]])
