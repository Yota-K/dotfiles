local status, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

nvim_treesitter_configs.setup({
  ensure_installed = {
    "css",
    "fish",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "php",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "graphql",
    "prisma",
    "astro",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {
    -- markdownのsyntaxがおかしくなるので無効化
    "markdown",
  },
  highlight = {
    enable = true,
  },
  modules = {},
})
