local trouble = require 'trouble'
local builtin = require 'telescope.builtin'
local neotree = require 'neo-tree.command'
local gitsigns = require 'gitsigns'
local dap = require 'dap'
local which_key = require 'which-key'

local function visual_lines()
  vim.cmd [[execute "normal! \<ESC>"]]
  local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
  local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
  return { start_line, end_line }
end

local function open_neotree_with_reveal_file()
  local reveal_file = vim.fn.expand '%:p'
  if reveal_file == '' then
    reveal_file = vim.fn.getcwd()
  else
    local f = io.open(reveal_file, 'r')
    if f then
      f.close(f)
    else
      reveal_file = vim.fn.getcwd()
    end
  end
  neotree.execute { reveal_file = reveal_file, reveal_force_cwd = true }
end

which_key.add {
  { '<leader>s', group = 'Search' },
  { '<leader>l', group = 'LSP' },
  { '<leader>g', group = 'Git' },
  { '<leader>d', group = 'Debug' },
}

-- stylua: ignore start

local grep_open_files = function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end
local toggle_diagnostics = function() trouble.toggle 'diagnostics' end
local stage_visual_hunk = function() gitsigns.stage_hunk(visual_lines()) end
local reset_visual_hunk = function() gitsigns.reset_hunk(visual_lines()) end
local dismiss_notifications = function() require('notify').dismiss { silent = true, pending = true } end
local dap_quit = function() dap.terminate() require("dapui").close() require("nvim-dap-virtual-text").toggle() end
local dap_list_breakpoints = function() dap.list_breakpoints() trouble.open('quickfix') end
local diagnostic_jump_down = function() vim.diagnostic.jump { count = -1, float = true } end
local diagnostic_jump_up = function() vim.diagnostic.jump { count = 1, float = true } end

local all = { 'v', 'x', 'n' }

vim.keymap.set('n', '<leader>sf',           builtin.find_files,                     { desc = 'Search Files' })
vim.keymap.set('n', '<leader>so',           builtin.oldfiles,                       { desc = 'Search Old Files' })
vim.keymap.set('n', '<leader>ss',           builtin.spell_suggest,                  { desc = 'Search Spell suggestions' })
vim.keymap.set('n', '<leader>sh',           builtin.help_tags,                      { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sk',           builtin.keymaps,                        { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sw',           builtin.grep_string,                    { desc = 'Search Word' })
vim.keymap.set('n', '<leader>sg',           builtin.live_grep,                      { desc = 'Search Grep' })
vim.keymap.set('n', '<leader>sd',           builtin.diagnostics,                    { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr',           builtin.resume,                         { desc = 'Search Resume' })
vim.keymap.set('n', '<leader>s/',           grep_open_files,                        { desc = 'Search Grep in Open Files' })
vim.keymap.set('n', '<leader>sz',           builtin.current_buffer_fuzzy_find,      { desc = 'Search Fuzzy in Buffer' })
vim.keymap.set('n', '<leader>sb',           builtin.buffers,                        { desc = 'Search Buffers' })
vim.keymap.set('n', '<leader>sc',           builtin.colorscheme,                    { desc = 'Search Colorschemes' })
vim.keymap.set('n', '<leader>st',           vim.cmd.TodoTelescope,                  { desc = 'Search TODOs' })
vim.keymap.set('n', '<leader>sm',           builtin.git_commits,                    { desc = 'Search Commits' })
vim.keymap.set('n', '<leader>se',           builtin.git_branches,                   { desc = 'Search Branches' })
vim.keymap.set('n', '<leader>su',           builtin.git_status,                     { desc = 'Search Status' })

vim.keymap.set('n', '<leader>ld',           builtin.lsp_definitions,                { desc = 'LSP: Definitions' })
vim.keymap.set('n', '<leader>lf',           builtin.lsp_references,                 { desc = 'LSP: References' })
vim.keymap.set('n', '<leader>lm',           builtin.lsp_implementations,            { desc = 'LSP: Implementation' })
vim.keymap.set('n', '<leader>lt',           builtin.lsp_type_definitions,           { desc = 'LSP: Type Definitions' })
vim.keymap.set('n', '<leader>ls',           builtin.lsp_document_symbols,           { desc = 'LSP: Document Symbols' })
vim.keymap.set('n', '<leader>lw',           builtin.lsp_dynamic_workspace_symbols,  { desc = 'LSP: Workspace Symbols' })
vim.keymap.set('n', '<leader>li',           builtin.lsp_incoming_calls,             { desc = 'LSP: Incoming Calls' })
vim.keymap.set('n', '<leader>lo',           builtin.lsp_outgoing_calls,             { desc = 'LSP: Outgoing Calls' })
vim.keymap.set('n', '<leader>lr',           vim.lsp.buf.rename,                     { desc = 'LSP: Rename' })
vim.keymap.set(all, '<leader>la',           vim.lsp.buf.code_action,                { desc = 'LSP: Code Action' })
vim.keymap.set('n', '<S-k>',                vim.lsp.buf.hover,                      { desc = 'LSP: Hover' })
vim.keymap.set('n', '<leader>lc',           vim.lsp.buf.declaration,                { desc = 'LSP: Declaration' })
vim.keymap.set('n', '<leader>lh',           vim.lsp.buf.document_highlight,         { desc = 'LSP: Document Highlight' })
vim.keymap.set('i', '<C-s>',                vim.lsp.buf.signature_help,             { desc = 'LSP: Signature Help' })
vim.keymap.set('n', '<leader>ll',           toggle_diagnostics,                     { desc = 'LSP: Diagnostics' })
vim.keymap.set('n', '<leader>ln',           diagnostic_jump_up,                     { desc = 'LSP: Diagnostic Next Message' })
vim.keymap.set('n', '<leader>lp',           diagnostic_jump_down,                   { desc = 'LSP: Diagnostic Prev Message' })
vim.keymap.set('n', '<leader>le',           vim.diagnostic.open_float,              { desc = 'LSP: Diagnostic Message' })

vim.keymap.set('n', '<leader>gh',           gitsigns.preview_hunk,                  { desc = 'Git Hunk preview' })
vim.keymap.set('n', '<leader>gl',           gitsigns.setqflist,                     { desc = 'Git Hunk List' })
vim.keymap.set('n', '<leader>gd',           gitsigns.diffthis,                      { desc = 'Git Diff' })
vim.keymap.set('n', '<leader>gv',           gitsigns.select_hunk,                   { desc = 'Git Hunk Visual' })
vim.keymap.set('n', '<leader>gu',           gitsigns.undo_stage_hunk,               { desc = 'Git Hunk Unstage' })
vim.keymap.set(all, '<leader>gs',           stage_visual_hunk,                      { desc = 'Git Hunk Stage' })
vim.keymap.set(all, '<leader>gr',           reset_visual_hunk,                      { desc = 'Git Hunk Reset' })
vim.keymap.set('n', '<leader>gg',           vim.cmd.Git,                            { desc = 'Git Fugitive' })

vim.keymap.set('n', '<leader>dd',           dap.toggle_breakpoint,                  { desc = 'Debug Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dc',           dap.continue,                           { desc = 'Debug Continue' })
vim.keymap.set('n', '<leader>di',           dap.step_into,                          { desc = 'Debug Inside' })
vim.keymap.set('n', '<leader>do',           dap.step_over,                          { desc = 'Debug Over' })
vim.keymap.set('n', '<leader>du',           dap.step_out,                           { desc = 'Debug Out' })
vim.keymap.set('n', '<leader>dr',           dap.repl.open,                          { desc = 'Debug Repl' })
vim.keymap.set('n', '<leader>dq',           dap_quit,                               { desc = 'Debug Quit' })
vim.keymap.set('n', '<leader>dl',           dap_list_breakpoints,                   { desc = 'Debug List Breakpoints' })
vim.keymap.set('n', '<leader>dr',           dap.clear_breakpoints,                  { desc = 'Debug Remove Breakpoints' })

vim.keymap.set('n', '<leader>n',            open_neotree_with_reveal_file,          { desc = 'Neotree' })

vim.keymap.set('n', '<leader>,',            dismiss_notifications,                  { desc = 'Notification Dismiss' })

vim.keymap.set('n', '<C-h>',                '<C-w><C-h>',                           { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>',                '<C-w><C-l>',                           { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>',                '<C-w><C-j>',                           { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>',                '<C-w><C-k>',                           { desc = 'Move focus to the upper window' })

vim.keymap.set('v', 'J',                    ":m '>+1<CR>gv=gv",                     { desc = 'Move selection one line up' })
vim.keymap.set('v', 'K',                    ":m '<-2<CR>gv=gv",                     { desc = 'Move selection one line down' })

vim.keymap.set('n', '<C-d>',                '<C-d>zz',                              { desc = 'Center on down jump' })
vim.keymap.set('n', '<C-u>',                '<C-u>zz',                              { desc = 'Center on up jump' })
vim.keymap.set('n', 'n',                    'nzzzv',                                { desc = 'Center on next search' })
vim.keymap.set('n', 'N',                    'Nzzzv',                                { desc = 'Center on prev search' })

vim.keymap.set('x', '<leader>p',            '"_dP',                                 { desc = "Paste without yanking" })
