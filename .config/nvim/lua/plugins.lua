local status = pcall(require, 'packer')
if (not status) then
  print('Packer is not installed')
  return
end

-- this file can be loaded by calling `lua require('plugins')` from your init.vim

-- only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- プラグインマネージャ
  use 'wbthomason/packer.nvim'

  -- ウィンドウサイズの変更を簡単にできるようにする
  use {'simeji/winresizer', opt = true, cmd = {'WinResizerStartResize'}}

  --  エメット
  use {'mattn/emmet-vim', opt = true, ft = {'html', 'javascriptreact', 'typescriptreact', 'vue', 'php', 'ejs', 'svelte'}}

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- vim helpを日本語化
  use 'vim-jp/vimdoc-ja'

  -- 各種Lintを非同期実行
  use 'w0rp/ale'

  -- コメントアウトを効率化
  use 'terrortylor/nvim-comment'

  -- ホバーしてる単語をカレントディレクトリ内から検索
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}

  -- ripgrepをnvim上で実行して、検索結果をQuickfixに表示
  use {'duane9/nvim-rg', opt = true, cmd ={'Rg'}}

  -- 複数ファイルの一括置換
  use {'thinca/vim-qfreplace', opt = true, cmd = {'Qfreplace'}}

  -- プロジェクトルートをカレントディレクトリにする
  use 'mattn/vim-findroot'

  -- テーマ
  use 'EdenEast/nightfox.nvim'

  -- アイコンフォント
  use 'ryanoasis/vim-devicons'

  -- ファイラー
  use {'lambdalisue/fern.vim',
    requires = {
      {'lambdalisue/fern-renderer-devicons.vim', 'lambdalisue/glyph-palette.vim', 'lambdalisue/fern-git-status.vim'},
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

  -- fuzzy finder 
  use {'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or, branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- markdown preview use glow
  use {'ellisonleao/glow.nvim',
    opt = true,
    config = function()
      require('glow').setup({
        pager = true,
        width = 120,
        height = 100,
      })
    end,
    cmd = {'Glow'}
  }

  -- カラーコードの色を見えやすいように表示
  use {'norcalli/nvim-colorizer.lua',
    config = function ()
      require'colorizer'.setup()
    end,
  }
end)
