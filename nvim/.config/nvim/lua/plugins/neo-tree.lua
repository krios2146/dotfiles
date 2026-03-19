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
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
        hijack_netrw_behavior = 'open_default',
        follow_current_file = { enabled = true },
      },
      default_component_configs = {
        name = {
          use_git_status_colors = false,
        },
        last_modified = {
          format = '%Y-%m-%d %H:%M',
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
          event = 'neo_tree_window_after_open',
          handler = function()
            if _G._neo_tree_initial_closed == true then
              return
            end
            _G._neo_tree_initial_closed = true

            vim.schedule(function()
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.bo[buf].filetype
                if ft ~= 'neo-tree' then
                  vim.api.nvim_win_close(win, true)
                end
              end
            end)
          end,
        },
      },
    },
    config = function(_, opts)
      require('neo-tree').setup(opts)
      vim.api.nvim_set_hl(0, 'NeoTreeDotfile', { link = 'NeoTreeDimText' })
      vim.api.nvim_set_hl(0, 'NeoTreeFileStats', { link = 'NeoTreeFileName' })
      vim.api.nvim_set_hl(0, 'NeoTreeFileStatsHeader', { link = 'NeoTreeFileName', bold = true })
    end,
  },
}
