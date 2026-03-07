return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    config = function()
      require('luasnip').setup {
        update_events = { 'TextChanged', 'TextChangedI' }, -- Live update of dynamic snippet nodes
        ext_opts = {
          [require('luasnip.util.types').choiceNode] = {
            active = {
              virt_text = { { '●', 'DiagnosticHint' } }, -- Add virt_text if on the choiceNode
            },
          },
        },
      }
      require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/lua/snippets' } }
    end,
  },
}
