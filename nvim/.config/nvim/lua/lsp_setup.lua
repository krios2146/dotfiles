local configs = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },

  vue_ls = {
    filetype = { 'typescript', 'javascript', 'vue' },
    init_options = {
      vue = { hybridMode = false },
    },
  },

  ts_ls = {},

  tailwindcss = {},

  ltex = {},

  basedpyright = {
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

  -- https://go.dev/gopls/settings
  gopls = {
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

  harper_ls = {},

  ocamllsp = {},

  ruby_lsp = {},

  gleam = {},

  kotlin_lsp = {},
}

local language_tools = {
  'stylua',
  'prettier',
  'eslint_d',
  'black',
  'mypy',
  'goimports',
  'ocamlformat',
  'rubocop',
  'erb-formatter',
  'erb-lint',
}

local function concat(a, b)
  local res = {}

  for _, v in ipairs(a) do
    table.insert(res, v)
  end
  for _, v in ipairs(b) do
    table.insert(res, v)
  end

  return res
end

local server_names = {}

for server_name, server_config in pairs(configs) do
  vim.lsp.config(server_name, server_config)
  vim.lsp.enable(server_name)

  table.insert(server_names, server_name)
end

-- NOTE: Gleam should be installed without Mason
for i, v in ipairs(server_names) do
  if v == 'gleam' then
    table.remove(server_names, i)
    break
  end
end

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = vim.tbl_deep_extend('force', default_capabilities, require('cmp_nvim_lsp').default_capabilities())
vim.lsp.config('*', { capabilities = cmp_capabilities })

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

require('mason-tool-installer').setup {
  ensure_installed = concat(server_names, language_tools),
}

vim.lsp.inlay_hint.enable(true)
