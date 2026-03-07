return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      attach_to_untracked = true,
      on_attach = function()
        local gitsigns = require 'gitsigns'

        local function get_visual_lines()
          vim.cmd [[execute "normal! \<ESC>"]]

          local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
          local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]

          return start_line, end_line
        end

        local function select_wise_hunk_reset()
          local start_line, end_line = get_visual_lines()

          if start_line == 0 and end_line == 0 then
            gitsigns.reset_hunk()
            return
          end

          gitsigns.reset_hunk { start_line, end_line }
        end

        local function select_wise_hunk_stage()
          local start_line, end_line = get_visual_lines()

          if start_line == 0 and end_line == 0 then
            gitsigns.stage_hunk()
            return
          end

          gitsigns.stage_hunk { start_line, end_line }
        end

        vim.keymap.set('n', '<S-h>', gitsigns.preview_hunk, { desc = '[H]unk preview' })
        vim.keymap.set('n', '<leader>gh', gitsigns.setqflist, { desc = '[G]it [H]unks' })
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [D]iff' })
        vim.keymap.set('n', '<leader>hv', gitsigns.select_hunk, { desc = '[H]unk [V]isual select' })
        vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[H]unk [U]nstage' })
        vim.keymap.set({ 'v', 'x', 'n' }, '<leader>hs', select_wise_hunk_stage, { desc = '[H]unk [S]tage' })
        vim.keymap.set({ 'v', 'x', 'n' }, '<leader>hr', select_wise_hunk_reset, { desc = '[H]unk [R]eset' })
      end,
    },
  },
}
