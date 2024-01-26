-- package.path初期値にtheme.luaが存在するパスを追加する。
-- 環境変数としてデフォルトで指定されているパスは以下
--
-- /usr/local/share/lua/5.4/?.lua;
-- /usr/local/share/lua/5.4/?/init.lua;
-- /usr/local/lib/lua/5.4/?.lua;
-- /usr/local/lib/lua/5.4/?/init.lua;
-- ./?.lua;
-- ./?/init.lua
local base_module_path = ";" .. os.getenv("HOME") .. "/dotfiles/?.lua;"
local plugin_module_path = ";" .. os.getenv("HOME") .. "/dotfiles/.config/nvim/plugin_settings/?.lua;"
package.path = package.path .. base_module_path .. plugin_module_path

-- テーマ: デフォルトにないテーマを使う時はここに記述する
return {
  "ellisonleao/gruvbox.nvim",
  -- "EdenEast/nightfox.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    -- load the colorscheme here
    vim.cmd("colorscheme gruvbox")
    -- vim.cmd("colorscheme nightfox")
    -- vim.cmd('colorscheme carbonfox')
  end,
  -- init is called during startup. Configuration for vim plugins typically should be set in an init function
  init = function()
    local theme = require("theme")
    local settings = theme.theme_override_settings()
    require("gruvbox").setup({
      override = settings,
    })
  end,
}
