local function get_dropdown_layout(height, width, transparency)
  return {
    layout_strategy = 'cursor',
    layout_config = {
      height = height or 0.5,
      width = width or 0.5,
    },
    initial_mode = 'normal',
    winblend = transparency or 30,
    sorting_strategy = 'ascending',
  }
end

local open_with_trouble = require('trouble.sources.telescope').open

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' }, -- It sets `vim.ui.select` to telescope. Used in `code_action` for example
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'folke/trouble.nvim' },
    },
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.5, -- Make default preview bigger
          },
        },
        mappings = {
          i = { ['<M-q>'] = open_with_trouble },
          n = { ['<M-q>'] = open_with_trouble },
        },
      },
      pickers = {
        spell_suggest = get_dropdown_layout(0.35, 0.4),
      },
      extensions = { -- Mainly used for code_action
        ['ui-select'] = get_dropdown_layout(0.4, 0.7),
      },
    },
  },
}
