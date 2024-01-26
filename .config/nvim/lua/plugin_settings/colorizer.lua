-- カラーコードの色を見えやすいように表示
return {
  "norcalli/nvim-colorizer.lua",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    require("colorizer").setup()
  end,
}
