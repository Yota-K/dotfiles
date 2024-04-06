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

opt.helplang = "ja,en"
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

-- 拡張子がmdxの時は、*.mdとして扱う
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.mdx",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})
