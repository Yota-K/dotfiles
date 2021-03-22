"----------------------------------------
" プラグイン
"----------------------------------------

call plug#begin()

" 1, ファイラー
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
" 2, アイコン
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }
" 3, インデントの可視化
Plug 'Yggdroot/indentLine'
" 4, ウィンドウサイズの変更を簡単にする
Plug 'simeji/winresizer'
" 5, ステータスバーのカスタマイズ
Plug 'itchyny/lightline.vim'
" 6, gitの情報を表示
Plug 'tpope/vim-fugitive'
" 7, 補完
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 8, エメット
Plug 'mattn/emmet-vim'
" 9, jsx・tsxのシンタックスハイライト
Plug 'othree/yajs.vim', { 'for': ['jsx', 'tsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['jsx', 'tsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'tsx' }
" 10, vim helpを日本語化
Plug 'vim-jp/vimdoc-ja' 
" 11, 各種Lintを非同期実行
Plug 'w0rp/ale'
" 12, コメントアウトを効率化
Plug 'tyru/caw.vim'
" 13, 定義元ジャンプ
Plug 'pechorin/any-jump.vim', { 'on': 'AnyJump' }
" 14, earthboundのテーマ
Plug 'benbusby/vim-earthbound-themes'
" 15, テンプレートを管理するプラグイン
Plug 'mattn/sonictemplate-vim'

call plug#end()
