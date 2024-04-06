-- increment/decrementを拡張する
return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>", mode = "n" },
    { "<C-x>", mode = "n" },
    { "g<C-a>", mode = "n" },
    { "g<C-x>", mode = "n" },
    { "<C-a>", mode = "v" },
    { "<C-x>", mode = "v" },
    { "g<C-a>", mode = "v" },
    { "g<C-x>", mode = "v" },
  },
  config = function()
    local dial_map = require("dial.map")
    local noremap = { noremap = true }

    vim.keymap.set("n", "<C-a>", dial_map.inc_normal(), noremap)
    vim.keymap.set("n", "<C-x>", dial_map.dec_normal(), noremap)
    vim.keymap.set("n", "g<C-a>", dial_map.inc_gnormal(), noremap)
    vim.keymap.set("n", "g<C-x>", dial_map.dec_gnormal(), noremap)
    vim.keymap.set("v", "<C-a>", dial_map.inc_visual(), noremap)
    vim.keymap.set("v", "<C-x>", dial_map.dec_visual(), noremap)
    vim.keymap.set("v", "g<C-a>", dial_map.inc_gvisual(), noremap)
    vim.keymap.set("v", "g<C-x>", dial_map.dec_gvisual(), noremap)

    local augend = require("dial.augend")

    require("dial.config").augends:register_group({
      default = {
        -- toggle text format types
        augend.case.new({
          types = { "camelCase", "snake_case", "kebab-case", "SCREAMING_SNAKE_CASE", "PascalCase" },
        }),
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.constant.alias.ja_weekday, -- Japanese weekday	月, 火, ..., 土, 日
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
      },
    })
  end,
}
