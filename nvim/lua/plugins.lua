return {
  { 'tpope/vim-sleuth' }, -- Detect `tabstop` and `shiftwidth` automatically
  { 'numToStr/Comment.nvim', opts = {} },
  { 'windwp/nvim-ts-autotag', opts = {} },
  { 'tpope/vim-fugitive' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { enabled = false } },
  { 'rktjmp/lush.nvim' },
  { 'folke/which-key.nvim', event = 'VeryLazy' },
  { 'stevearc/dressing.nvim', opts = {} },
  {
    'wakatime/vim-wakatime',
    lazy = false,
    opts = {
      status_bar_enabled = false,
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      attach_to_untracked = true,
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} }, -- Useful status updates for LSPs
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'nvim-lspconfig',
      },
    },
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = { enabled = false, scope = { show_start = false, show_end = false } },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      completions = {
        lsp = { enabled = true },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'phrmendes/todotxt.nvim',
    opts = {
      todotxt = vim.env.HOME .. '/Documents/notes/todo.txt',
    },
  },
}
