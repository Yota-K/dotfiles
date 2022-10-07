--  __/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_        
--   _\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_       
--    _\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_      
--     __\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_     
--      ___\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_    
--       ____\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_   
--        _____\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_  
--         ______\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_ 
--          _______\///________\///////////__\///______________\///__
-- 
vim.opt.encoding = 'utf-8'

vim.opt.helplang = 'ja,en'
vim.opt.numberwidth = 6

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
