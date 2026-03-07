local function jump_down()
  vim.diagnostic.jump { count = -1, float = true }
end

local function jump_up()
  vim.diagnostic.jump { count = 1, float = true }
end

vim.keymap.set('n', '<leader>dp', jump_down, { desc = '[D]iagnostic [P]revious message' })
vim.keymap.set('n', '<leader>dn', jump_up, { desc = '[D]iagnostic [N]ext message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = '[D]iagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection one line up' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection one line down' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center screen on down jump' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center screen on up jump' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center screen on next search result jump' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center screen on previous search result jump' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = "Paste but don't yank selected text to the register" })
