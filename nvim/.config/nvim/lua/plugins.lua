return {
  { 'tpope/vim-sleuth' }, -- Detect `tabstop` and `shiftwidth` automatically
  { 'numToStr/Comment.nvim', opts = {} },
  { 'windwp/nvim-ts-autotag', opts = {} },
  { 'wakatime/vim-wakatime' },
  { 'tpope/vim-fugitive' },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { enabled = false } },
  { 'rktjmp/lush.nvim' },
  { 'folke/which-key.nvim', event = 'VeryLazy' },
  { 'stevearc/dressing.nvim', opts = {} },
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      actions = {
        open_file = { quit_on_open = true },
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      integrations = {
        ['mason-lspconfig'] = true,
      },
      run_on_start = true,
    },
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
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
}
