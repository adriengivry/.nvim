return {
  'Civitasv/cmake-tools.nvim',
  opts = {
    cmake_regenerate_on_save = false,
    cmake_executor = {
      name = 'overseer',
      opts = {},
      default_opts = {
        overseer = {
          on_new_task = function(task) require('overseer').open { enter = false, direction = 'bottom' } end,
        },
      },
    },
    cmake_runner = {
      name = 'overseer',
      opts = {},
      default_opts = {
        overseer = {
          on_new_task = function(task) require('overseer').open { enter = false, direction = 'bottom' } end,
        },
      },
    },
    cmake_dap_configuration = {
      name = 'cpp',
      type = 'lldb',
      request = 'launch',
      stopOnEntry = false,
      runInTerminal = true,
      console = 'integratedTerminal',
    },
  },
}
