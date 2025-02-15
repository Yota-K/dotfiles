-- テーマ: デフォルトにないテーマを使う時はここに記述する
return {
  -- "ellisonleao/gruvbox.nvim",
  "ribru17/bamboo.nvim",
  -- "EdenEast/nightfox.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    -- vim.cmd([[ colorscheme gruvbox ]])
    -- vim.cmd([[ colorscheme nightfox ]])
    -- vim.cmd([[ colorscheme carbonfox ]])

    -- -- theme.luaがあるパスを追加する
    local module_path = ";" .. os.getenv("HOME") .. "/dotfiles/?.lua;"
    package.path = package.path .. module_path

    local theme = require("theme")
    local settings = theme.theme_override_settings()

    require("bamboo").setup({
      override = settings,
    })
    require("bamboo").load()
  end,
}
