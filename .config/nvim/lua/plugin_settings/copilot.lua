-- GitHub Copilot
return {
  "zbirenbaum/copilot.lua",
  event = { "VimEnter" },
  config = function()
    require("copilot").setup({
      suggestion = {
        -- 自動補完を有効にする
        auto_trigger = true,
        keymap = {
          -- 補完を確定する
          accept = "<C-a>",
        },
      },
    })
  end,
}
