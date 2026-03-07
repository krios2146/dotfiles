-- Auto linter
return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        vue = { 'eslint_d' },
        eruby = { 'erb_lint' },
        ruby = { 'rubocop' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>dl', lint.try_lint, { desc = '[D]ocument [L]int' })
    end,
  },
}
