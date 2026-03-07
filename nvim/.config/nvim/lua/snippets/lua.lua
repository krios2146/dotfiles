---@diagnostic disable: undefined-global

local treesitter_postfix = require('luasnip.extras.treesitter_postfix').treesitter_postfix

return {
  treesitter_postfix(
    {
      matchTSNode = {
        query = [[
                (function_declaration
                  name: (identifier) @fname
                  parameters: (parameters) @params
                  body: (block) @body
                ) @prefix
            ]],
        query_lang = 'lua',
      },
      trig = '.var',
    },
    fmt(
      [[
        local {} = function{}
            {}
        end
    ]],
      {
        l(l.LS_TSCAPTURE_FNAME),
        l(l.LS_TSCAPTURE_PARAMS),
        l(l.LS_TSCAPTURE_BODY),
      }
    )
  ),
}
