return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '',
        section_separators = '',
        disabled_filetypes = {
          statusline = { 'neo-tree', 'trouble' },
        },
        globalstatus = true,
      },
      sections = {
        lualine_c = { { 'filename', path = 4, color = { bg = 'NONE', ctermbg = 'NONE', blend = 100 } } },
        lualine_x = { { 'filetype', color = { bg = 'NONE', ctermbg = 'NONE', blend = 100 } } },
      },
      extensions = { 'fugitive', 'trouble', 'lazy', 'mason', 'neo-tree' },
    },
  },
}
