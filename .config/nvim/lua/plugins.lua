-- Install and configure lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy")

-- Set mapleader
vim.g.mapleader = " "

require("lazy").setup("plugin_settings", {
  defaults = {
    lazy = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  -- "Config Change Detected. Reloading..."通知を無効にする
  -- https://github.com/folke/lazy.nvim/issues/32
  change_detection = {
    notify = false,
  },
})
