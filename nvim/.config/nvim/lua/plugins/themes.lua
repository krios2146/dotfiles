return {
  { 'marko-cerovac/material.nvim' },
  { 'ray-x/aurora' },
  {
    'Shatur/neovim-ayu',
    config = function()
      require('ayu').setup {
        overrides = {
          CursorLine = { bg = '#111822' },
          CursorLineNr = { bg = '#111822' },
          CursorColumn = { bg = '#111822' },
          ColorColumn = { bg = '#111822' },
          CursorLineConceal = { bg = '#111822' },
        },
      }
    end,
  },
  { 'nanotech/jellybeans.vim' },
  { 'krios2146/1984.nvim' },
}
