-- fuzzy finder
return {
  "nvim-telescope/telescope.nvim",
  cmd = {
    "Telescope",
  },
  keys = { { "ff", mode = "n" }, { "fg", mode = "n" }, { "fb", mode = "n" } },
  tag = "0.1.7",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { ".yarn", ".git", "node_modules" },
      },
      pickers = {
        -- Search for a string and get results live as you type, respects .gitignore
        live_grep = {
          additional_args = function()
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

    -- gitで変更されたファイルを検索
    keyset("n", "fgs", builtin.git_status, {})
  end,
}
