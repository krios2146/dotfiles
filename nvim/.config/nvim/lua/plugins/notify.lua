return {
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require 'notify'

      notify.setup {
        fps = 60,
        max_width = 40,
        render = 'wrapped-compact',
      }

      vim.notify = notify
    end,
  },
}
