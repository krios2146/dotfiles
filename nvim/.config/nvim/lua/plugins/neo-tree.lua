return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = {
      enable_diagnostics = false,
      popup_border_style = '',
      window = {
        mappings = {
          ['<CR>'] = 'open',
          ['e'] = 'rename_basename',
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        name = {
          use_git_status_colors = false,
        },
        git_status = {
          symbols = {
            added = '✚',
            deleted = '✖',
            modified = '',
            renamed = '󰁕',
            untracked = '',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            conflict = '',
          },
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            vim.cmd 'Neotree close'
          end,
        },
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            _G._cursor_hl_backup = vim.api.nvim_get_hl(0, { name = 'Cursor' })
            vim.cmd 'highlight! CursorIM blend=100'
            vim.cmd 'highlight! Cursor blend=100'
          end,
        },
        {
          event = 'neo_tree_buffer_leave',
          handler = function()
            if _G._cursor_hl_backup then
              vim.api.nvim_set_hl(0, 'CursorIM', { blend = 0 })
              vim.api.nvim_set_hl(0, 'Cursor', { blend = 0 })
            end
          end,
        },
      },
    },
  },
}
