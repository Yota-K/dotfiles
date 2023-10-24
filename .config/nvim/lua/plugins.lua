-- package.path初期値にtheme.luaが存在するパスを追加する。
-- 環境変数としてデフォルトで指定されているパスは以下
--
-- /usr/local/share/lua/5.4/?.lua;
-- /usr/local/share/lua/5.4/?/init.lua;
-- /usr/local/lib/lua/5.4/?.lua;
-- /usr/local/lib/lua/5.4/?/init.lua;
-- ./?.lua;
-- ./?/init.lua
local base_module_path = ";" .. os.getenv("HOME") .. "/dotfiles/?.lua;"
local plugin_module_path = ";" .. os.getenv("HOME") .. "/dotfiles/.config/nvim/plugin_settings/?.lua;"
package.path = package.path .. base_module_path .. plugin_module_path

-- Install and configure lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy")

-- Set mapleader
vim.g.mapleader = " "

-- Load plugins using lazy.nvim syntax
require("lazy").setup({
  -- メインで使用してるテーマ
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd("colorscheme nightfox")
      -- vim.cmd('colorscheme carbonfox')
    end,
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      local theme = require("theme")

      require("nightfox").setup({
        groups = {
          nightfox = theme.theme_override_settings("nightfox"),
          carbonfox = theme.theme_override_settings("carbonfox"),
        },
      })
    end,
  },

  -- ウィンドウサイズの変更を簡単にできるようにする
  { "simeji/winresizer", cmd = "WinResizerStartResize" },

  --  エメット
  {
    "mattn/emmet-vim",
    ft = { "html", "javascriptreact", "typescriptreact", "vue", "php", "ejs", "svelte" },
    init = function()
      require("plugin_settings.emmet")
    end,
  },

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("plugin_settings.treesitter")
    end,
  },

  -- vim helpを日本語化
  {
    "vim-jp/vimdoc-ja",
    lazy = true,
    -- コマンドモードで "h" が入力された時のみ読み込む
    keys = {
      { "h", mode = "c" },
    },
  },

  -- 各種Lintを非同期実行
  "w0rp/ale",

  -- コメントアウトを効率化
  {
    "terrortylor/nvim-comment",
    event = "VeryLazy",
    config = function()
      require("plugin_settings.comment-out")
    end,
  },

  -- ホバーしてる単語をカレントディレクトリ内から検索
  {
    "pechorin/any-jump.vim",
    cmd = "AnyJump",
    config = function()
      require("plugin_settings.any-jump")
    end,
  },

  -- ripgrepをnvim上で実行して、検索結果をQuickfixに表示
  { "duane9/nvim-rg", cmd = "Rg" },

  -- 複数ファイルの一括置換
  { "thinca/vim-qfreplace", cmd = "Qfreplace" },

  -- プロジェクトルートをカレントディレクトリにする
  "mattn/vim-findroot",

  -- アイコンフォント
  "ryanoasis/vim-devicons",

  -- ファイラー
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/fern-renderer-devicons.vim",
      "lambdalisue/glyph-palette.vim",
      "lambdalisue/fern-git-status.vim",
    },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    -- 既存のファイルの編集を開始する or 存在しないファイルの編集を開始した時に読み込む
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("plugin_settings.lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
      "MasonUpdate",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
  },
  "hrsh7th/vim-vsnip",
  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- syntax for astro
  { "elel-dev/vim-astro-syntax", ft = { "astro" } },

  -- ステータスライン
  "nvim-lualine/lualine.nvim",

  -- Git操作
  "dinhhuy258/git.nvim",

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = {
      "Telescope",
    },
    keys = { { "ff", mode = "n" }, { "fg", mode = "n" }, { "fb", mode = "n" }, { "fh", mode = "n" } },
    event = { "BufReadPre", "BufNewFile" },
    tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugin_settings.telescope")
    end,
  },

  -- カラーコードの色を見えやすいように表示
  {
    "norcalli/nvim-colorizer.lua",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- increment/decrementを拡張する
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", mode = "n" },
      { "<C-x>", mode = "n" },
      { "g<C-a>", mode = "n" },
      { "g<C-x>", mode = "n" },
      { "<C-a>", mode = "v" },
      { "<C-x>", mode = "v" },
      { "g<C-a>", mode = "v" },
      { "g<C-x>", mode = "v" },
    },
    config = function()
      require("plugin_settings.dial")
    end,
  },

  -- Luaのフォーマッター
  {
    "mhartington/formatter.nvim",
    cmd = { "Format", "FormatWrite" },
    config = function()
      require("plugin_settings.formatter")
    end,
  },
})
