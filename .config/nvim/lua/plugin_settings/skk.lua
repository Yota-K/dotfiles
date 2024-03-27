return {
  "vim-skk/skkeleton",
  dependencies = {
    { "vim-denops/denops.vim" },
  },
  lazy = false,
  init = function()
    -- Control + tを押した時に読み込むようにしたいが、フリーズするため起動時に読み込むようにしている
    vim.keymap.set("i", "<C-t>", "<Plug>(skkeleton-toggle)")
    vim.keymap.set("c", "<C-t>", "<Plug>(skkeleton-toggle)")

    vim.api.nvim_create_autocmd("User", {
      -- skkeletonが最初に有効化された際に実行される
      pattern = "skkeleton-initialize-pre",
      callback = function()
        vim.fn["skkeleton#config"]({
          -- 変換モードで改行キーを押した際に確定のみを行う
          eggLikeNewline = true,
          globalDictionaries = {
            vim.fn.expand("~/.skk/SKK-JISYO.L"),
          },
        })
      end,
    })
  end,
  config = function()
    -- カタカナモードに切り替える
    vim.fn["skkeleton#register_keymap"]("input", "q", "katakana")
  end,
}
