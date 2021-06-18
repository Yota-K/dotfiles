let g:ale_linters = {  
\   'javascript': ['eslint'],  
\   'markdown': ['textlint']
\}  

" ALEFixコマンドで各種リンターを実行できるようにする
" ALE can fix files with the ALEFix command.
" Functions need to be configured either in each buffer with a b:ale_fixers, or globally with g:ale_fixers.
let b:ale_fixers = ['prettier', 'eslint', 'gofmt']

" ファイル保存時に実行
let g:ale_fix_on_save = 1

" ローカルの設定ファイルを考慮する
let g:ale_javascript_prettier_use_local_config = 1
