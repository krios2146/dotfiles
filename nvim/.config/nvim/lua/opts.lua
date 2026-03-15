vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = { eob = ' ' }

vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.opt.termguicolors = true

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false -- if `true` everything will be folded by default

vim.opt.spell = true
vim.opt.spelllang = 'en,ru'

vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = false

vim.diagnostic.config { virtual_text = true }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
