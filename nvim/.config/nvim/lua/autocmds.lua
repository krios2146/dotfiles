vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('transparent-lualine', { clear = true }),
  callback = function()
    for _, mode in ipairs { 'normal', 'insert', 'visual', 'command', 'replace', 'inactive' } do
      vim.api.nvim_set_hl(0, 'lualine_c_' .. mode, { bg = 'NONE', ctermbg = 'NONE', blend = 100 })
    end
    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE', blend = 100 })
    vim.api.nvim_set_hl(0, 'lualine_transparent', { bg = 'NONE', ctermbg = 'NONE', blend = 100 })
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    local ft = vim.bo.filetype
    if ft == 'neo-tree' then
      _G._cursor_backup = _G._cursor_backup or vim.o.guicursor
      vim.api.nvim_set_hl(0, 'noCursor', { blend = 100, strikethrough = true })
      vim.opt.guicursor = 'a:noCursor'
    else
      if _G._cursor_backup then
        vim.o.guicursor = _G._cursor_backup
        _G._cursor_backup = nil
      end
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
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),

  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then
      return
    end

    -- document highlights
    if client:supports_method 'textDocument/documentHighlight' then
      local group = vim.api.nvim_create_augroup('lsp-highlight-' .. event.buf, { clear = true })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = group,
        buffer = event.buf,
        desc = 'LSP document highlight',
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        buffer = event.buf,
        desc = 'LSP clear references',
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-highlight-detach-' .. event.buf, { clear = true }),
        buffer = event.buf,
        desc = 'LSP clear highlight augroup on detach',
        callback = function()
          vim.api.nvim_del_augroup_by_name('lsp-highlight-' .. event.buf)
        end,
      })
    end

    -- code lenses
    if client:supports_method 'textDocument/codeLens' then
      vim.lsp.codelens.enable(true, { bufnr = event.buf })
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
