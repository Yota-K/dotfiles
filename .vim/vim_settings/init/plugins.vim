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
" 7, jsx・tsxのシンタックスハイライト
Plug 'othree/yajs.vim', { 'for': ['jsx', 'tsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['jsx', 'tsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'tsx' }
" 8, vim helpを日本語化
Plug 'vim-jp/vimdoc-ja' 
" 9, 各種Lintを非同期実行
Plug 'w0rp/ale'
" 10, コメントアウトを効率化
Plug 'tyru/caw.vim'
" 11, 定義元ジャンプ
Plug 'pechorin/any-jump.vim', { 'on': 'AnyJump' }
" 12, earthboundのテーマ
Plug 'benbusby/vim-earthbound-themes'
" 13, テンプレートを管理するプラグイン
Plug 'mattn/sonictemplate-vim'
" 14, Vimからagを使えるようにする
Plug 'rking/ag.vim', { 'on': 'Ag' }

call plug#end()
