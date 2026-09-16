---@type table<string, vim.lsp.Config>
local configs = {
  lua_ls = {},

  vue_ls = {
    filetype = { 'typescript', 'javascript', 'vue' },
    init_options = {
      vue = { hybridMode = false },
    },
  },

  ts_ls = {},

  tailwindcss = {},

  basedpyright = {
    ---@type lspconfig.settings.basedpyright
    settings = {
      basedpyright = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportAny = false,
          },
        },
      },
    },
  },

  gopls = {
    ---@type lspconfig.settings.gopls
    settings = {
      gopls = {
        usePlaceholders = true,
        staticcheck = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          ignoredError = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedvariable = true,
        },
      },
    },
  },

  ocamllsp = {},

  ruby_lsp = {},

  gleam = {},

  kotlin_lsp = {},

  clangd = {
    cmd = { 'clangd', '--clang-tidy' },
  },

  markdown_oxide = {},

  codebook = {},

  zls = {},

  harper_ls = {
    settings = {
      ['harper-ls'] = {
        dialect = 'British',
        linters = {
          NumericRangeEnDash = false,
          ExpandMemoryShorthands = false,
        },
      },
    },
  },

  rust_analyzer = {},
}

for server_name, server_config in pairs(configs) do
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)
end

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', { capabilities = vim.tbl_deep_extend('force', default_capabilities, cmp_capabilities) })

vim.lsp.inlay_hint.enable(true)

vim.diagnostic.config {
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
}
