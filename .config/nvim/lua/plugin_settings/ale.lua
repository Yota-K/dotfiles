-- 解説記事: https://kuune.org/text/2017/07/23/how-to-lint-and-autoformat-with-ale/
vim.cmd(
  [[
    " 言語ごとに有効にするLintツールを設定する
    let g:ale_linters = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'javascriptreact': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'typescriptreact': ['eslint', 'prettier'],
      \ 'vue': ['eslint', 'prettier'],
      \ 'css': ['stylelint', 'prettier'],
      \ 'scss': ['stylelint', 'prettier'],
      \ 'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
      \ }

    " 言語ごとの自動整形を行うリンターの設定を行う
    let g:ale_fixers = {
      \ 'javascript': ['eslint', 'prettier'],
      \ 'json': ['eslint', 'prettier'],
      \ 'javascriptreact': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'typescriptreact': ['eslint', 'prettier'],
      \ 'vue': ['eslint', 'prettier'],
      \ 'css': ['stylelint', 'prettier'],
      \ 'scss': ['stylelint', 'prettier'],
      \ 'go': ['gofmt', 'goimports', 'remove_trailing_lines', 'trim_whitespace'],
      \ 'astro': ['prettier'],
      \ }

    " ファイル保存時に実行
    let g:ale_fix_on_save = 1

    " ローカルの設定ファイルを考慮する
    let g:ale_javascript_prettier_use_local_config = 1
  ]]
)
