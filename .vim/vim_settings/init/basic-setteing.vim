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
"----------------------------------------
" 基本の設定
"----------------------------------------

set encoding=UTF-8

set t_Co=256

" 全角スペースにシンタックスハイライトをかける
augroup highlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" vimのヘルプ機能を日本語化
set helplang=ja,en

" タイトルを表示
set title

" 行番号を表示
" set number
set numberwidth=5

" vimを使ってくれてありがとうを非表示
set notitle

" カーソルの位置を表示する
set ruler

" 不可視文字を可視化 (タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" インデント周りの設定
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set autoindent
set smartindent

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

" ヤンクしたテキストをクリップボードにもコピーできるようにする
set clipboard+=unnamed
" set clipboard+=unnamed,autoselect

" コマンドの補完
set wildmenu
set history=5000

" 画面分割のキーバインドを変更
map vsplit vs
map split sp

" 行を折り返さない
set nowrap

" HTMLとXMLの閉じタグの補完
augroup MyXML
  autocmd!
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

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

" インクリメント・デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" ESC連打でハイライト解除
nnoremap <Esc> :noh<CR>

" 矢印キー無効化 (矢印使って移動するのは甘え)
noremap <Left> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>

" 行番号の表示切り替え
nnoremap <Space>n :set invnumber<CR>

" GlowをVim経由で実行
nnoremap <Space>p :GlowOpen<CR>

" 外部grepで検索対象から除外するディレクトリを指定
set grepprg=grep\ -rnIH\ --exclude-dir=node_modules\ --exclude-dir=.*\ --exclude-dir=out\ --exclude-dir=build\ --exclude-dir=vendor

"----------------------------------------
" 普通のVimのみに適用したい設定
"----------------------------------------

if !has('nvim')
  " 記号などで字が潰れるのを防ぐ
  set ambiwidth=double
endif
