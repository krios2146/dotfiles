return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local ayu_dark = require 'lualine.themes.ayu_dark'
      local ayu_colors = require 'ayu.colors'
      ayu_dark.normal.c.bg = ayu_colors.bg

      require('lualine').setup {
        options = {
          theme = ayu_dark,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_x = { 'filetype' },
        },
        extensions = { 'fugitive', 'trouble', 'lazy', 'mason', 'nvim-tree' },
      }
    end,
  },
}
