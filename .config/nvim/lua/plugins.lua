-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- TODO: プラグインの遅延読込あたり設定する
return require('packer').startup(function(use)
  -- プラグインマネージャ
  use 'wbthomason/packer.nvim'

  -- ウィンドウサイズの変更を簡単にできるようにする
  use 'simeji/winresizer'

  --  エメット
  use 'mattn/emmet-vim'

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  use 'nvim-treesitter/nvim-treesitter'

  -- vim helpを日本語化
  use 'vim-jp/vimdoc-ja'

  -- 各種Lintを非同期実行
  use 'w0rp/ale'

  -- コメントアウトを効率化
  use 'tyru/caw.vim'

  -- 定義元ジャンプ
  use 'pechorin/any-jump.vim'

  -- Vimからagを使えるようにする
  use 'rking/ag.vim'

  -- 複数ファイルの一括置換
  use 'thinca/vim-qfreplace'

  -- プロジェクトルートをカレントディレクトリにする
  use 'mattn/vim-findroot'

  -- テーマ
  use 'NLKNguyen/papercolor-theme'

  -- アイコン
  use 'ryanoasis/vim-devicons'

  -- ファイラー
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'
  use 'lambdalisue/fern-git-status.vim'
  use 'lambdalisue/glyph-palette.vim'

  -- lsp
  use { 'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile' }

  -- astroのsyntax
  use 'elel-dev/vim-astro-syntax'

  -- ステータスライン
  use 'nvim-lualine/lualine.nvim'

  -- Git操作
  use 'dinhhuy258/git.nvim'
end)
