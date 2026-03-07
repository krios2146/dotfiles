-- Autocompletion
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'onsails/lspkind.nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      local luasnip_jump_forward = function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end

      local luasnip_jump_back = function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end

      local luasnip_choice_next = function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end

      local luasnip_choice_prev = function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<Enter>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(luasnip_jump_forward, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(luasnip_jump_back, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(luasnip_choice_next, { 'i', 's' }),
          ['<C-j>'] = cmp.mapping(luasnip_choice_prev, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            menu = {
              buffer = '[Buffer]',
              path = '[Path]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              nvim_lua = '[Lua]',
              latex_symbols = '[Latex]',
            },
          },
        },
      }
    end,
  },
}
