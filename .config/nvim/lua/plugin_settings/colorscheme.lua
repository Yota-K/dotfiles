local module_path = ";" .. os.getenv("HOME") .. "/dotfiles/.config/wezterm/?.lua;"
package.path = package.path .. module_path

-- テーマ: デフォルトにないテーマを使う時はここに記述する
return {
  -- "ellisonleao/gruvbox.nvim",
  -- "EdenEast/nightfox.nvim",
  "catppuccin/nvim",
  -- catppuccinのテーマを使用するためにnameの設定が必要
  name = "catppuccin",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    -- vim.cmd("colorscheme gruvbox")
    -- vim.cmd("colorscheme nightfox")
    -- vim.cmd('colorscheme carbonfox')
    vim.cmd("colorscheme catppuccin")
  end,
  -- init is called during startup. Configuration for vim plugins typically should be set in an init function
  init = function()
    -- theme.luaがあるパスを追加する
    local module_path = ";" .. os.getenv("HOME") .. "/dotfiles/?.lua;"
    package.path = package.path .. module_path
    local theme = require("theme")

    local settings = theme.theme_override_settings()
    -- require("gruvbox").setup({
    --   override = settings,
    -- })
    --
    require("catppuccin").setup({
      color_overrides = settings,
    })
  end,
}
