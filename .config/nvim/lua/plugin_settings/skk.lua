-- 日本語入力を強化
return {
  "vim-skk/skkeleton",
  dependencies = {
    { "vim-denops/denops.vim" },
  },
  lazy = false,
  init = function()
    -- Control + jを押した時に読み込むようにしたいが、フリーズするため起動時に読み込むようにしている
    vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)")
    vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)")

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
    -- 全角モードに切り替える
    vim.g["skkeleton#mapped_keys"] = { "<C-l>" }
    vim.fn["skkeleton#register_keymap"]("input", "<C-l>", "zenkaku")

    -- ひらがなモードだと「・」が入力できないので、「z/」に割り当てる
    vim.fn["skkeleton#register_kanatable"]("rom", {
      ["z/"] = { "・", "" },
    }, true)
  end,
}
