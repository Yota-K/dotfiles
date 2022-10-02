vim.opt.encoding = 'utf-8'

vim.opt.helplang = 'ja,en'
vim.opt.numberwidth = 5

vim.opt.ruler = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showcmd = true

vim.opt.laststatus = 2

vim.opt.showmatch.matchtime = 1

vim.opt.backspace = 'indent,eol,start'

vim.opt.virtualedit = 'onemore'

vim.opt.swapfile = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.wildmenu = true
vim.opt.history = 5000

vim.opt.wrap = false

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.cmd [[
  augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
  augroup END

  " 拡張子がmdxの時は、*.mdとして扱う
  au BufNewFile,BufRead *.mdx set filetype=markdown
]]
