-- fuzzy finder
return {
  "nvim-telescope/telescope.nvim",
  cmd = {
    "Telescope",
  },
  keys = { { "ff", mode = "n" }, { "fg", mode = "n" }, { "fb", mode = "n" }, { "fh", mode = "n" } },
  event = { "BufReadPre", "BufNewFile" },
  tag = "0.1.3",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        color_devicons = true,
        file_ignore_patterns = { ".git/", ".yarn" },
      },
      pickers = {
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
    })

    local keyset = vim.keymap.set

    -- ファイル名で検索
    keyset("n", "ff", function()
      builtin.find_files({
        no_ignore = false,
        hidden = true,
      })
    end)

    -- ファイルに含まれる文字列で検索
    keyset("n", "fg", builtin.live_grep, {})

    -- neovimで開いているバッファで検索
    keyset("n", "fb", builtin.buffers, {})

    -- helpを開く
    keyset("n", "fh", builtin.help_tags, {})
  end,
}
