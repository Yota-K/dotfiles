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
  use {'mattn/emmet-vim', opt = true, ft = {'html', 'javascriptreact', 'typescriptreact', 'vue', 'php', 'ejs'}}

  -- tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- vim helpを日本語化
  use 'vim-jp/vimdoc-ja'

  -- 各種Lintを非同期実行
  use 'w0rp/ale'

  -- コメントアウトを効率化
  use 'terrortylor/nvim-comment'

  -- 定義元ジャンプ
  use {'pechorin/any-jump.vim', opt = true, cmd = {'AnyJump'}}

  -- 複数ファイルの一括置換
  use {'thinca/vim-qfreplace', opt = true, cmd = {'Qfreplace'}}

  -- プロジェクトルートをカレントディレクトリにする
  use 'mattn/vim-findroot'

  -- テーマ
  use {'EdenEast/nightfox.nvim',
    config = function()
      local groups = {
        nightfox = {
          -- 補完メニューのホバーしたときの色
          CocMenuSel = { bg = '#73daca', fg = 'bg0'},
          -- 補完メニューのスクロールバーの色
          PmenuThumb = { bg = 'white'},
          -- 境界線の色
          VertSplit = { fg = '#2d333b'},
          -- タブの色を背景色と同化させる
          TabLineFill = { bg = '#172331'}
        },
      }

      require('nightfox').setup({ groups = groups })

      vim.cmd('colorscheme nightfox')
    end
  }

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

  -- fuzzy finder 
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or, branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- markdown preview use glow
  use {'ellisonleao/glow.nvim',
    opt = true,
    config = function()
      require('glow').setup({ pager = true })
    end,
    cmd = {'Glow'}
  }
end)
