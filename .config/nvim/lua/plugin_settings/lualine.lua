local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local cusutom = require('lualine.themes.nightfox')

local nightfox_dark = '#172331'
-- local carbonfox_dark = '#161616'

-- nightfox
cusutom.inactive.c.bg = nightfox_dark
cusutom.normal.c.bg = nightfox_dark
--
-- carbonfox
-- cusutom.inactive.c.bg = carbonfox_dark
-- cusutom.normal.c.bg = carbonfox_dark

lualine.setup {
  options = {
    icons_enabled = true,
    theme = cusutom,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = ''},
    disabled_filetypes = {},
    globalstatus = true
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
      },
      'encoding',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
