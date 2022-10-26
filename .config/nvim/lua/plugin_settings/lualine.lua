local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local cusutom_nightfly = require('lualine.themes.nightfly')

local base_colors = {
  black = '#1c1c1c',
  text_color = '#fffff'
}

-- normal mode
-- cusutom_nightfly.normal.a.bg = base_colors['black']
-- cusutom_nightfly.normal.a.fg = 'white'
-- cusutom_nightfly.normal.b.bg = base_colors['black']
cusutom_nightfly.normal.c.bg = base_colors['black']

-- default
-- cusutom_nightfly.inactive.a.bg = base_colors['black']
-- cusutom_nightfly.inactive.b.bg = base_colors['black']
cusutom_nightfly.inactive.c.bg = base_colors['black']

lualine.setup {
  options = {
    icons_enabled = true,
    theme = cusutom_nightfly,
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
    lualine_c = {'filename'},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
