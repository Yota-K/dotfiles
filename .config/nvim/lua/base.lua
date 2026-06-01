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
-- 行番号の表示幅
opt.numberwidth = 6
-- ステータスラインにカーソル位置を表示
opt.ruler = true
-- インデント幅を2スペースに設定
opt.shiftwidth = 2
-- タブ幅を2スペースに設定
opt.tabstop = 2
-- タブをスペースに展開
opt.expandtab = true
-- 自動インデントを有効化
opt.autoindent = true
-- スマートインデントを有効化
opt.smartindent = true
-- 入力中のコマンドを表示
opt.showcmd = true
-- 対応する括弧をハイライト表示する時間（0.1秒）
opt.showmatch.matchtime = 1
-- バックスペースで削除できる範囲を指定
opt.backspace = "indent,eol,start"
-- カーソルを行末より1文字先まで移動可能に
opt.virtualedit = "onemore"
-- スワップファイルを作成しない
opt.swapfile = false
-- システムのクリップボードと連携
opt.clipboard = "unnamedplus"
-- コマンドライン補完を有効化
opt.wildmenu = true
-- コマンド履歴の保存数
opt.history = 5000
-- 行の折り返しを無効化
opt.wrap = false
-- インクリメンタル検索を有効化
opt.incsearch = true
-- 検索結果をハイライト表示
opt.hlsearch = true
-- 検索時に大文字小文字を区別しない
opt.ignorecase = true
-- 大文字を含む場合は大文字小文字を区別
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

-- ログの肥大化を防止するため、nvim本体のログをtmpに退避
vim.env.NVIM_LOG_FILE = '/tmp/nvim.log'

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

-- プロジェクトルートをカレントディレクトリにする (vim.fs.root による findroot 代替)
-- ref: https://github.com/mattn/vim-findroot/tree/master
local findroot_group = vim.api.nvim_create_augroup("findroot", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = findroot_group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    local bufname = vim.api.nvim_buf_get_name(args.buf)
    if bufname == "" or bufname:find("://", 1, true) then
      return
    end

    -- git管理されているプロジェクトをルートとしてカレントディレクトリを変更する
    local root = vim.fs.root(args.buf, { ".git", ".gitignore" })
    if not root then
      return
    end

    local cwd = vim.fs.normalize(vim.fn.getcwd()):lower()
    if cwd:find(vim.fs.normalize(root):lower(), 1, true) == 1 then
      return
    end

    vim.cmd.lcd(root)
  end,
})
