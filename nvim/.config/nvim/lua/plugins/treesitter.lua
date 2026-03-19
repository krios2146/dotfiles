return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
          if not require('nvim-treesitter.parsers')[lang] then
            return
          end

          local has_parser = pcall(vim.treesitter.language.inspect, lang)
          local has_highlights = has_parser and vim.treesitter.query.get(lang, 'highlights') ~= nil

          if not has_parser or not has_highlights then
            require('nvim-treesitter').install { lang }
            return
          end

          vim.treesitter.start(ev.buf, lang)
          if vim.treesitter.query.get(lang, 'indents') then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
