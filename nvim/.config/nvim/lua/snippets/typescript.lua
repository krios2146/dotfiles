local function get_file_name()
  local buff_name = vim.api.nvim_buf_get_name((vim.api.nvim_get_current_buf()))
  local file_name = buff_name:match('%w+%.ts'):gsub('.ts', '')

  return file_name
end

---@diagnostic disable: undefined-global
return {
  s(
    'edi',
    fmt(
      [[
      export default interface () {
          ()
      }
      ]],
      { f(get_file_name), i(1) },
      { delimiters = '()' }
    )
  ),

  s('dbg', fmt([[console.debug(`{}`)]], { i(1, '') })),
}
