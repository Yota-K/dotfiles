local status, lualine = pcall(require, 'lualine')
if (not status) then return end

local cusutom = require('lualine.themes.nightfox')

-- theme.luaがあるパスを追加する
local module_path = ';'..os.getenv('HOME')..'/dotfiles/?.lua;'
package.path = package.path..module_path
local theme = require('theme')

-- nightfox
cusutom.inactive.c.bg = theme.colors['nightfox']
cusutom.normal.c.bg = theme.colors['nightfox']
--
-- carbonfox
-- cusutom.inactive.c.bg = theme.colors['carbonfox']
-- cusutom.normal.c.bg = theme.colors['carbonfox']

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
