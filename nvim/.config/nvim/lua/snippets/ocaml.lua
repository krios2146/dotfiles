---@diagnostic disable: undefined-global

return {
  s('lgfn', fmt([[(fun m -> m "{}")]], { i(1, '') })),
  s('debug', fmt([[Log.debug (fun m -> m "{}");]], { i(1, '') })),
  s('info', fmt([[Log.info (fun m -> m "{}");]], { i(1, '') })),
  s('error', fmt([[Log.error (fun m -> m "{}");]], { i(1, '') })),
  s('warn', fmt([[Log.warn (fun m -> m "{}");]], { i(1, '') })),
}
