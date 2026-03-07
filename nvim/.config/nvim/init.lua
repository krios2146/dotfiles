vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'opts'
require 'keymaps_default'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  checker = {
    enabled = { true },
    notify = { true },
  },
}

require 'keymaps_plugins'
require 'lsp_setup'
require 'autocmds'

-- vim: ts=2 sts=2 sw=2 et
