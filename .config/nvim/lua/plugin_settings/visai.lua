-- visualモードで選択したテキストに対してAIを使って編集を行う
return {
  "Yota-K/visai.nvim",
  keys = {
    { "ae", mode = "v" },
  },
  config = function()
    require("visai").setup()
  end,
}
