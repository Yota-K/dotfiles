-- プロジェクトルートをカレントディレクトリにする
return {
  "mattn/vim-findroot",
  event = { "VimEnter" },
  config = function()
    vim.cmd([[
      let g:findroot_patterns = [
      \  '.git/',
      \  '.gitignore',
      \]
    ]])
  end,
}
