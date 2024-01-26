-- Git操作
return {
  "dinhhuy258/git.nvim",
  event = { "VimEnter" },
  config = function()
    local git = require("git")

    git.setup({
      keymaps = {
        diff = "<Space>g",
        -- vim上でgit blame
        blame = "<Space>gb",
        -- 開いているコードをgitのリポジトリーで開く:w
        browse = "<Space>go",
      },
    })
  end,
}
