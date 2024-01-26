-- vim helpを日本語化
return {
  "vim-jp/vimdoc-ja",
  lazy = true,
  -- コマンドモードで "h" が入力された時のみ読み込む
  keys = {
    { "h", mode = "c" },
  },
}
