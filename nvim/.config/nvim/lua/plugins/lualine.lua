return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '',
        section_separators = '',
      },
      sections = {
        lualine_c = { { 'filename', path = 4, color = 'lualine_transparent' } },
        lualine_x = { { 'filetype', color = 'lualine_transparent' } },
      },
      extensions = { 'fugitive', 'trouble', 'lazy', 'mason', 'nvim-tree' },
    },
  },
}
