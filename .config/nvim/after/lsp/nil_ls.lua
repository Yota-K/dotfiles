---@type vim.lsp.Config
return {
  settings = {
    ["nil"] = {
      nix = {
        flake = {
          -- 以下の警告を解消するために、lspの設定で autoArchive を有効にする
          --
          --Some flake inputs are not available. Fetch them now?
          -- You can enable autoArchive in lsp configuration.
          -- (1)Fetch, (2)Ignore missing ones:
          autoArchive = true,
        },
      },
    },
  },
}
