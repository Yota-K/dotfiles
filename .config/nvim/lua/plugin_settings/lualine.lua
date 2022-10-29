local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local cusutom = require('lualine.themes.nightfox')

local dark = '#172331'

cusutom.inactive.c.bg = dark
cusutom.normal.c.bg = dark
cusutom.insert.c.bg = dark
cusutom.command.c.bg = dark
cusutom.terminal.c.bg = dark
cusutom.visual.c.bg = dark

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
