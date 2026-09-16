return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'jay-babu/mason-nvim-dap.nvim',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require('nvim-dap-virtual-text').setup()
      local mason_dap = require 'mason-nvim-dap'
      local dap = require 'dap'
      local ui = require 'dapui'
      local dap_utils = require 'dap.utils'

      mason_dap.setup {
        ensure_installed = { 'delve' },
        automatic_installation = true,
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      }

      dap.configurations.go = {
        {
          type = 'delve',
          name = 'Attach',
          request = 'attach',
          mode = 'local',
          processId = require('dap.utils').pick_process,
        },
      }

      ui.setup()

      dap.listeners.before.attach.dapui_config = ui.open
      dap.listeners.before.launch.dapui_config = ui.open
      dap.listeners.before.event_terminated.dapui_config = ui.close
      dap.listeners.before.event_exited.dapui_config = ui.close

      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '◎', texthl = 'DapLogPoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStopped', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
    end,
  },
}
