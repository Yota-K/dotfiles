--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--

local opt = vim.opt

opt.encoding = "utf-8"

opt.helplang = "ja"
opt.numberwidth = 6

opt.ruler = true

opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.showcmd = true

opt.showmatch.matchtime = 1

opt.backspace = "indent,eol,start"

opt.virtualedit = "onemore"

opt.swapfile = false

opt.clipboard = "unnamedplus"

opt.wildmenu = true
opt.history = 5000

opt.wrap = false

opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Global Status Line を有効にする
-- 画面をスプリットした時に Status LineはSplitされないようにする
opt.laststatus = 3

-- エラーやヒントがある時は行数の部分を上書きして表示する
opt.signcolumn = "number"

-- ターミナルでも True Color を使えるようにする
opt.termguicolors = true
-- ポップアップメニューに透過を付与する
opt.pumblend = 20

-- ログの肥大化を防止するため、ログの保存先をtmpに変更
vim.env.XDG_STATE_HOME = '/tmp'

-- マウス操作を無効化
vim.api.nvim_set_option('mouse', '')

-- storybookで使用される可能性あり
-- 拡張子がmdxの時は、*.mdとして扱うことで、markdownとして認識させる
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.mdx", "*.mdc" },
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

-- 使用しているテーマ関係なく必ず有効にしたい配色の設定
local ideographic_space = vim.api.nvim_create_augroup("highlightIdeographicSpace", { clear = true })

-- 全角スペースをハイライト表示するためのカラー定義
vim.api.nvim_create_autocmd("ColorScheme", {
  group = ideographic_space,
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "IdeographicSpace", {
      underline = true,
      ctermbg = "DarkGreen",
      bg = "DarkGreen",
    })
  end,
})

-- ウィンドウを開いた時に全角スペースのマッチを有効化
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter" }, {
  group = ideographic_space,
  pattern = "*",
  command = [[match IdeographicSpace /　/]],
})

-- StatusLine / TabLineFill / SignColumn の背景をテーマに依存させず透過させる
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "StatusLine", {})
    vim.api.nvim_set_hl(0, "TabLineFill", { ctermbg = "NONE", bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", {})
  end,
})
