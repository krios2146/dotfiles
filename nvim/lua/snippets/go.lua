---@diagnostic disable: undefined-global
return {
  s(
    'iferr',
    fmt(
      [[
if err != nil {{
	{}
}}
]],
      {
        i(1, ''),
      }
    )
  ),
}
