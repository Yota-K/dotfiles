-- this file can be loaded by calling `lua require('plugins')` from your init.vim

-- only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- プラグインマネージャ
  use 'wbthomason/packer.nvim'

  -- ウィンドウサイズの変更を簡単にできるようにする
  use {'simeji/winresizer', opt = true, cmd = {'WinResizerStartResize'}}

  --  エメット
  use {'mattn/emmet-vim', opt = true, ft = {'html', 'jsx', 'tsx', 'vue', 'php', 'ejs'}}

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- vim helpを日本語化
  use 'vim-jp/vimdoc-ja'

  -- 各種Lintを非同期実行
  use 'w0rp/ale'

  -- コメントアウトを効率化
  use 'tyru/caw.vim'

  -- 定義元ジャンプ
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}

  -- Vimからagを使えるようにする
  use {'rking/ag.vim', opt = true, cmd = {'Ag'}}

  -- 複数ファイルの一括置換
  use {'thinca/vim-qfreplace', opt = true, cmd = {'Qfreplace'}}

  -- プロジェクトルートをカレントディレクトリにする
  use 'mattn/vim-findroot'

  -- テーマ
  use 'NLKNguyen/papercolor-theme'

  -- アイコンフォント
  use 'ryanoasis/vim-devicons'

  -- ファイラー
  use {'lambdalisue/fern.vim',
    requires = {
      {'lambdalisue/fern-renderer-devicons.vim', 'lambdalisue/fern-git-status.vim', 'lambdalisue/glyph-palette.vim'},
    },
  }

  -- lsp
  use {'neoclide/coc.nvim', run = 'yarn install --frozen-lockfile'}

  -- astroのsyntax
  use {'elel-dev/vim-astro-syntax', ft = {'astro'}}

  -- ステータスライン
  use 'nvim-lualine/lualine.nvim'

  -- Git操作
  use 'dinhhuy258/git.nvim'
end)
