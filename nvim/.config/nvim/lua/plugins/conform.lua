return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        lsp_fallback = true,
      },
      formatters_by_ft = {
        cpp = { 'clang_format' },
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        vue = { 'prettier' },
        python = { 'black' },
        go = { 'goimports' },
        ocaml = { 'ocamlformat' },
        ruby = { 'rubocop' },
        eruby = { 'erb-formatter' },
      },
    },
  },
}
