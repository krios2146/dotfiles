local M = {}
M.main_vault_path = '/mnt/ssd/obsidian-vault'

return {
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'vault',
          path = M.main_vault_path,
        },
        {
          name = 'test',
          path = '/mnt/ssd/obsidian-vault-test',
        },
      },
      completion = { min_chars = 0 },
      mappings = {
        ['gd'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<leader>sf'] = {
          action = function()
            vim.api.nvim_command 'ObsidianQuickSwitch'
          end,
          opts = { noremap = false, buffer = true },
        },
      },
      note_id_func = function(title)
        return title
      end,
      disable_frontmatter = true,
      templates = { folder = 'Templates' },
      attachments = { img_folder = 'Attachments' },
    },
  },
}
