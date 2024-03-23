return {
  "vim-skk/skkeleton",
  dependencies = {
    { "vim-denops/denops.vim" },
  },
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
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
    -- Control + jを押した時に読み込むようにしたいが、フリーズするため起動時に読み込むようにしている
    vim.cmd([[
      imap <C-j> <Plug>(skkeleton-enable)
      cmap <C-j> <Plug>(skkeleton-enable)
    ]])
  end,
}
