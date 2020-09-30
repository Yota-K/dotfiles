"----------------------------------------
" 表示or入力の設定
"----------------------------------------

" vimのヘルプ機能を日本語化
set helplang=ja,en

" タイトルを表示
set title

" 行番号を表示
set number
set numberwidth=5

" vimを使ってくれてありがとうを非表示
set notitle

" 記号などで字が潰れるのを防ぐ
set ambiwidth=double

" カーソルの位置を表示する
set ruler

" インデントを入れる
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

" 折り返し時に表示してる行単位で移動できるようにする
nnoremap j gj
nnoremap k gk

" スワップファイルを作成しないようにする
set noswapfile

" ヤンクしたテキストをクリップボードにもコピーできるようにする
set clipboard+=unnamed
set clipboard+=unnamed,autoselect

" コマンドの補完
set wildmenu
set history=5000

" 画面分割のキーバインドを変更
map vsplit vs
map split sp

" 行を折り返さない
set nowrap

" カレントディレクトリを自動的に変更
set autochdir

" HTMLとXMLの閉じタグの補完
augroup MyXML
  autocmd!
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END

" ()と{}と[]と引用符の補完
inoremap ( ()<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
