" 
" __/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_        
"  _\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_       
"   _\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_      
"    __\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_     
"     ___\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_    
"      ____\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_   
"       _____\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_  
"        ______\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_ 
"         _______\///________\///////////__\///______________\///__
" 
"
"----------------------------------------
" 基本の設定
"----------------------------------------

set encoding=UTF-8

" タイトルを表示
set title

" 行番号を表示
set number
set numberwidth=5

" 記号などで字が潰れるのを防ぐ
set ambiwidth=double

" カーソルの位置を表示する
set ruler

" 不可視文字を可視化 (タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" インデント周りの設定
" この辺はお好みで！
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent
set smartindent

"----------------------------------------
" 検索に関する設定
"----------------------------------------

" 1文字入力毎に検索を行う
set incsearch

" 検索結果をハイライト
set hlsearch 

" 検索時に英大小文字の区別を無視する
set ignorecase

" 全て英小文字で入力した場合のみ区別を無視する
set smartcase

" 入力中のコマンドを表示
set showcmd

" 検索結果をハイライトで表示
set hlsearch

" ステータスバーを表示
set laststatus=2

" 対応するかっこやプレースを表示
set showmatch matchtime=1

" 文字の削除をバックスペースでもできるようにする
set backspace=indent,eol,start

" 行末の1文字先までカーソルを移動できるようにする
set virtualedit=onemore

" スワップファイルを作成しないようにする
set noswapfile

" コマンドの補完
set wildmenu
set history=5000

" 画面分割のキーバインドを変更
map vsplit vs
map split sp

" 行を折り返さない
set nowrap

"----------------------------------------
" キーマッピング系
"----------------------------------------

" インサートモード時のキーマッピング
" ()と{}と[]と引用符の補完
inoremap (<Enter> ()<Left>
inoremap {<Enter> {}<Left>
inoremap [<Enter> []<Left>
inoremap "<Enter> ""<Left>
inoremap '<Enter> ''<Left>
inoremap `<Enter> ``<Left>

inoremap {<Space> {}<Left><CR><ESC><S-o>
inoremap [<Space> []<Left><CR><ESC><S-o>

" ノーマルモード時のキーマッピング
" 折り返し時に表示してる行単位で移動できるようにする
nnoremap j gj
nnoremap k gk

" ESC連打でハイライト解除
nnoremap <Esc><Esc> :noh<CR><Esc>

"----------------------------------------
" netrwの設定
"----------------------------------------

filetype plugin on
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_altv=1
let g:netrw_alto=1
let g:netrw_preview=1
let g:netrw_winsize=30

"----------------------------------------
" テーマ
"----------------------------------------

" シンタックスハイライトを有効に
syntax enable
