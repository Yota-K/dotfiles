" MEMO: 普通のVimで読み込むとエラーになるので、nvimで起動されているかどうかの判定を行う

if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "ruby" },  -- list of language that will be disabled
  },
}
EOF
endif
