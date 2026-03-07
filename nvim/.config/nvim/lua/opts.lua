-- Relative line setup
vim.opt.number = true
vim.opt.relativenumber = true

-- Set default tab to 4 for every language
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Colors
vim.opt.termguicolors = true

-- Set folding with treesitter
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable = false -- if `true` everything will be folded by default

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en,ru'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (used for git statuses signs, left to the number column)
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 50

-- Decrease mapped sequence wait time
-- Displays which-key pop-up sooner
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions as you type
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable highlight on / search
vim.opt.hlsearch = false
