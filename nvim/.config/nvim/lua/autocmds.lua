vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.ml', '*.mli' },
  group = vim.api.nvim_create_augroup('OCamlFormatting', { clear = true }),
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'perl',
  group = vim.api.nvim_create_augroup('PerlFormatting', { clear = true }),
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    require('ibl').setup_buffer(0, { enabled = true, scope = { enabled = false } })
  end,
})

local obsidian = require 'plugins.obsidian'
local main_vault_path = obsidian[1].opts.workspaces[1].path

-- Autoinsert template on note creation
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = main_vault_path .. '/*.md',
  group = vim.api.nvim_create_augroup('ObsidianInsertTemplate', { clear = true }),
  callback = function()
    vim.api.nvim_command 'ObsidianTemplate Template - Note'
  end,
})

-- Keymaps only for markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = vim.api.nvim_create_augroup('ObsidianSpecificMappings', { clear = true }),
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = '[O]bsidian [B]acklinks' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ot', '<cmd>ObsidianTags<CR>', { desc = '[O]bsidian [T]ags' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ol', '<cmd>ObsidianLinks<CR>', { desc = '[O]bsidian outgoing [L]inks' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>or', '<cmd>ObsidianRename<CR>', { desc = '[O]bsidian [R]ename note' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>it', 'ggdd<cmd>ObsidianTemplate Template - Note<CR>', { desc = '[I]nsert [T]emplate' })
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ii', '<cmd>ObsidianPasteImg<CR>', { desc = '[I]nsert [I]mage' })
  end,
})
