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

-- Install and configure lazy.nvim if not already installed
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  endvim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require('lazy')

-- Set mapleader
vim.g.mapleader = ' '

-- Load plugins using lazy.nvim syntax
require('lazy').setup({
  -- メインで使用してるテーマ
  {
    'EdenEast/nightfox.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd('colorscheme nightfox')
      -- vim.cmd('colorscheme carbonfox')
    end,
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      require('nightfox').setup({
        groups = {
          nightfox = theme.theme_override_settings('nightfox'),
          carbonfox = theme.theme_override_settings('carbonfox'),
        },
      })
    end,
  },

  -- ウィンドウサイズの変更を簡単にできるようにする
  { 'simeji/winresizer', cmd = 'WinResizerStartResize' },

  --  エメット
  { 'mattn/emmet-vim', ft = { 'html', 'javascriptreact', 'typescriptreact', 'vue', 'php', 'ejs', 'svelte' } },

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- vim helpを日本語化
  'vim-jp/vimdoc-ja', cmd = 'help',

  -- 各種Lintを非同期実行
  'w0rp/ale',

  -- コメントアウトを効率化
  'terrortylor/nvim-comment',

  -- ホバーしてる単語をカレントディレクトリ内から検索
  { 'pechorin/any-jump.vim', cmd = 'AnyJump' },

  -- ripgrepをnvim上で実行して、検索結果をQuickfixに表示
  { 'duane9/nvim-rg', cmd = 'Rg' },

  -- 複数ファイルの一括置換
  { 'thinca/vim-qfreplace', cmd = 'Qfreplace' },

  -- プロジェクトルートをカレントディレクトリにする
  'mattn/vim-findroot',

  -- アイコンフォント
  'ryanoasis/vim-devicons',

  -- ファイラー
  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/fern-renderer-devicons.vim',
      'lambdalisue/glyph-palette.vim',
      'lambdalisue/fern-git-status.vim',
    },
  },

  -- lsp
  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'hrsh7th/vim-vsnip',
  {
    'hrsh7th/nvim-cmp',
    -- load cmp on InsertEnter
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
  },

  -- syntax for astro
  { 'elel-dev/vim-astro-syntax', ft = { 'astro' } },

  -- ステータスライン
  'nvim-lualine/lualine.nvim',

  -- Git操作
  'dinhhuy258/git.nvim',

  -- fuzzy finder 
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- カラーコードの色を見えやすいように表示
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- increment/decrementを拡張する
  'monaqa/dial.nvim',
})
