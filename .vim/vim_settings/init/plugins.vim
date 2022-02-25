"----------------------------------------
" プラグイン
"----------------------------------------

call plug#begin()

" 1, インデントの可視化
Plug 'Yggdroot/indentLine'
" 2, ウィンドウサイズの変更を簡単にする
Plug 'simeji/winresizer'
" 3, ステータスバーのカスタマイズ
Plug 'itchyny/lightline.vim'
" 4, gitの情報を表示
Plug 'tpope/vim-fugitive'
" 5, 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 6, エメット
Plug 'mattn/emmet-vim'
" 7, tree-sitterを用いたコードのシンタックスハイライトを行うプラグイン
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" 8, vim helpを日本語化
Plug 'vim-jp/vimdoc-ja' 
" 9, 各種Lintを非同期実行
Plug 'w0rp/ale'
" 10, コメントアウトを効率化
Plug 'tyru/caw.vim'
" 11, 定義元ジャンプ
Plug 'pechorin/any-jump.vim', { 'on': 'AnyJump' }
" 12, テンプレートを管理するプラグイン
Plug 'mattn/sonictemplate-vim'
" 13, Vimからagを使えるようにする
Plug 'rking/ag.vim', { 'on': ['Ag', 'AgFile'] }
" 14, 複数ファイルの一括置換
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
" 15, タブにアイコンフォントを表示するために使用
Plug 'ryanoasis/vim-devicons'
" 16, quickfixで自由にファイルを開けるようにするためのプラグイン
Plug 'skanehira/qfopen.vim'
" 17, プロジェクトルートをカレントディレクトリにする
Plug 'mattn/vim-findroot'
" 18, github-nvim-theme
Plug 'projekt0n/github-nvim-theme'
" 19, Tailwind CSSの補完
Plug 'rodrigore/coc-tailwind-intellisense'

call plug#end()
