if has('nvim')
lua <<EOF
require("github-theme").setup({
  theme_style = "dark",
  function_style = "italic",
  sidebars = {"qf", "vista_kind"},

  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = {
    bg = "#000",
    hint = "orange",
    error = "#ff0000",
    cursor = "#6cb6ff",
    pmenu = {
      sbar = "#4cadfb",
    },
    bg_search = "#525151",
  },

  -- Overwrite the highlight groups
  overrides = function(c)
    return {
      htmlTag = {fg = c.red, bg = "#282c34", sp = c.hint, style = "underline"},
      DiagnosticHint = {link = "LspDiagnosticsDefaultHint"},
      -- this will remove the highlight groups
      TSField = {},
    }
  end
})
EOF
endif
