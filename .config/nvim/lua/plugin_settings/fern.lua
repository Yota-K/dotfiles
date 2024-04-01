-- ファイラー
return {
  "lambdalisue/fern.vim",
  event = { "VimEnter" },
  dependencies = {
    "lambdalisue/nerdfont.vim",
    "lambdalisue/fern-renderer-nerdfont.vim",
    "lambdalisue/glyph-palette.vim",
    "lambdalisue/fern-git-status.vim",
  },
  init = function()
    vim.api.nvim_set_keymap("n", "<C-n>", ":Fern . -reveal=% -drawer -toggle<CR>", { noremap = true, silent = true })
  end,
  config = function()
    vim.g["fern#renderer"] = "nerdfont"
    vim.g["fern#default_hidden"] = 1
    vim.g["fern#drawer_width"] = 40
    vim.g["fern#fern_disable_startup_warnings"] = 1

    local init_fern = function()
      local keymap_options = { noremap = false, buffer = true }

      vim.keymap.set("n", "i", "<Plug>(fern-action-open:split)", keymap_options)
      vim.keymap.set("n", "s", "<Plug>(fern-action-open:vsplit)", keymap_options)

      vim.keymap.set("n", "b", "<Plug>(fern-action-new-file)", keymap_options)
      vim.keymap.set("n", "B", "<Plug>(fern-action-new-dir)", keymap_options)
      vim.keymap.set("n", "r", "<Plug>(fern-action-rename)", keymap_options)

      vim.keymap.set("n", "d", "<Plug>(fern-action-trash)", keymap_options)
      vim.keymap.set("n", "D", "<Plug>(fern-action-remove)", keymap_options)

      vim.keymap.set("n", "dd", "<Plug>(fern-action-move)", keymap_options)
      vim.keymap.set("n", "y", "<Plug>(fern-action-clipboard-copy)", keymap_options)
      vim.keymap.set("n", "p", "<Plug>(fern-action-clipboard-paste)", keymap_options)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fern",
      callback = init_fern,
    })

    -- アイコンに色をつける
    vim.api.nvim_create_augroup("my-glyph-palette", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fern",
      callback = function()
        vim.cmd([[ call glyph_palette#apply() ]])
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "nerdtree", "startify" },
      callback = function()
        vim.cmd([[ call glyph_palette#apply() ]])
      end,
    })

    -- Error detected while processing function <lambda>1072[1]..<SNR>123_show[52]..<SNR>123_apply:
    -- line    4:
    -- E28: No such highlight group name: FernRootSymbolの解消
    -- Gitに追跡されていない、かつ、長いファイル名のときに発生した
    vim.cmd([[
      hi FernRootSymbol ctermfg=white guifg=white ctermbg=NONE guibg=NONE
    ]])
  end,
}
