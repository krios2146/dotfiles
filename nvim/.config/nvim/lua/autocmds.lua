vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('transparent-lualine', { clear = true }),
  callback = function()
    for _, mode in ipairs { 'normal', 'insert', 'visual', 'command', 'replace' } do
      vim.api.nvim_set_hl(0, 'lualine_c_' .. mode, { bg = 'NONE', ctermbg = 'NONE', blend = 100 })
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

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
