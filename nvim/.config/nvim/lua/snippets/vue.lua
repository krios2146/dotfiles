local sfc_component_template = {
  '<script setup lang="ts">',
  "console.log('')",
  '</script>',
  '',
  '<template>',
  '    <div>new template</div>',
  '</template>',
}

-- Insert sfc_component_template by default for an empty vue file
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = { '*.vue' },
  callback = function()
    local current_buffer = vim.api.nvim_get_current_buf()
    local buffer_lines = vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)

    if #buffer_lines == 1 then
      vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, sfc_component_template)
    end
  end,
})

---@diagnostic disable: undefined-global
return {
  s(
    'ref',
    fmt('const {} = ref<{}>({})', {
      i(1, 'name'),
      i(2, 'type'),
      i(3, 'ref'),
    })
  ),

  s(
    'con',
    fmt('const {}{} = {}', {
      i(1, 'name'),
      c(2, {
        t '',
        fmt(': {}', i(1, 'Type')),
      }),
      i(3, 'value'),
    })
  ),

  s('dbg', fmt([[console.debug(`{}`)]], { i(1, '') })),

  postfix(
    { trig = '.var', match_pattern = '[%w%.%_%-%(%)]+$' },
    d(1, function(_, parent)
      return sn(
        1,
        fmt('const {}{} = {}', {
          i(1, 'name'),
          c(2, {
            t '',
            fmt(': {}', i(1, 'Type')),
          }),
          t(parent.snippet.env.POSTFIX_MATCH),
        })
      )
    end)
  ),

  s('sfc', t(sfc_component_template)),
}
