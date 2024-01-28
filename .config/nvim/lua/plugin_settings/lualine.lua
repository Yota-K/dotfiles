-- ステータスライン
return {
  "nvim-lualine/lualine.nvim",
  event = { "VimEnter" },
  config = function()
    local lualine = require("lualine")

    -- local cusutom = require("lualine.themes.nightfox")
    local cusutom = require("lualine.themes.gruvbox")

    -- theme.luaがあるパスを追加する
    local module_path = ";" .. os.getenv("HOME") .. "/dotfiles/?.lua;"
    package.path = package.path .. module_path
    local theme = require("theme")

    local bg = theme.theme_config[theme.selected_theme]["bg"]
    cusutom.inactive.c.bg = bg
    cusutom.normal.c.bg = bg

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = cusutom,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            diff_color = {
              added = { fg = theme.colors["git_diff"]["added"] },
              modified = { fg = theme.colors["git_diff"]["modified"] },
              removed = { fg = theme.colors["git_diff"]["removed"] },
            },
          },
          "diagnostics",
        },
        lualine_c = { "filename" },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    })
  end,
}
