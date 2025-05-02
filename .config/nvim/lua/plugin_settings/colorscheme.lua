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

    require("bamboo").load()
  end,
}
