local trouble = require 'trouble'
local builtin = require 'telescope.builtin'
local neotree = require 'neo-tree.command'

local function current_file_or_dir()
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
  return reveal_file
end

local function open_neotree_at_current_file_or_dir()
  neotree.execute {
    reveal_file = current_file_or_dir(),
    reveal_force_cwd = true,
  }
end

local function builtin_grep_open_files()
  builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' }
end

local function builtin_config_files()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end

local function toggle_diagnostics_virtual_lines()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end

local function toggle_diagnostics()
  trouble.toggle 'diagnostics'
end

local function telescope_map_search(key, func, desc)
  vim.keymap.set('n', '<leader>s' .. key, func, { desc = '[S]earch ' .. desc })
end

local function telescope_map_git(key, func, desc)
  vim.keymap.set('n', '<leader>g' .. key, func, { desc = '[G]it ' .. desc })
end

local function map_lsp(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
end

vim.keymap.set('n', '<leader>gi', vim.cmd.Git, { desc = '[G]it [I]ntegration' })
vim.keymap.set('n', '<leader>st', vim.cmd.TodoTelescope, { desc = '[S]earch [T]ODOs' })

vim.keymap.set('n', '<leader>dl', toggle_diagnostics_virtual_lines, { desc = 'Toggle [D]iagnostic virtual [L]ines' })
vim.keymap.set('n', '<leader>dd', toggle_diagnostics, { desc = '[D]ocument [D]iagnostics' })

require('which-key').add {
  { '<leader>c', desc = '[C]ode' },
  { '<leader>d', desc = '[D]iagnostics & [D]ocument' },
  { '<leader>g', desc = '[G]it' },
  { '<leader>h', desc = 'Git [H]unk' },
  { '<leader>r', desc = '[R]ename' },
  { '<leader>s', desc = '[S]earch' },
  { '<leader>w', desc = '[W]orkspace' },
}

telescope_map_search('h', builtin.help_tags, '[H]elp')
telescope_map_search('k', builtin.keymaps, '[K]eymaps')
telescope_map_search('f', builtin.find_files, '[F]iles')
telescope_map_search('s', builtin.spell_suggest, '[S]pell suggestions')
telescope_map_search('w', builtin.grep_string, '[W]ord')
telescope_map_search('g', builtin.live_grep, '[G]rep')
telescope_map_search('d', builtin.diagnostics, '[D]iagnostics')
telescope_map_search('r', builtin.resume, '[R]esume')
telescope_map_search('o', builtin.oldfiles, '[O]ld Files')
telescope_map_search('/', builtin_grep_open_files, '[/] in Open Files')
telescope_map_search('n', builtin_config_files, '[N]eovim config')
telescope_map_search('<BS>', builtin.buffers, 'Existing buffers')
telescope_map_search('F', builtin.current_buffer_fuzzy_find, '[F]uzzy [F]ind Current buffer')
telescope_map_search('c', builtin.colorscheme, '[C]olorschemes')

telescope_map_git('c', builtin.git_commits, '[C]ommits')
telescope_map_git('b', builtin.git_branches, '[B]ranches')
telescope_map_git('s', builtin.git_status, '[S]status')

map_lsp('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
map_lsp('gr', builtin.lsp_references, '[G]oto [R]eferences')
map_lsp('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
map_lsp('<leader>td', builtin.lsp_type_definitions, '[T]ype [D]efinition')
map_lsp('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
map_lsp('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
map_lsp('<leader>ic', builtin.lsp_incoming_calls, '[I]ncoming [C]alls')
map_lsp('<leader>oc', builtin.lsp_incoming_calls, '[O]utgoing [C]alls')

map_lsp('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
map_lsp('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
map_lsp('K', vim.lsp.buf.hover, 'Hover Documentation')
map_lsp('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
map_lsp('<leader>dh', vim.lsp.buf.document_highlight, '[D]ocument [H]ighlight')

vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature [H]elp' })

vim.keymap.set('n', '<leader>pv', vim.cmd.Neotree, { desc = '[P]roject [V]iew' })

vim.keymap.set('n', '<leader>pv', open_neotree_at_current_file_or_dir, { desc = 'Open neo-tree at current file or working directory' })
