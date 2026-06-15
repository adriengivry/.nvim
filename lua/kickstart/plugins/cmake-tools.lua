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
  config = function(_, opts)
    require('cmake-tools').setup(opts)

    vim.keymap.set('n', '<Leader>cg', '<cmd>CMakeGenerate<CR>')
    vim.keymap.set('n', '<Leader>cb', '<cmd>CMakeBuild<CR>')
    vim.keymap.set('n', '<Leader>cr', '<cmd>CMakeRun<CR>')
    vim.keymap.set('n', '<Leader>cd', '<cmd>CMakeDebug<CR>')
    vim.keymap.set('n', '<Leader>ct', '<cmd>CMakeRunTest<CR>')
    vim.keymap.set('n', '<Leader>cB', '<cmd>CMakeQuickBuild<CR>')
    vim.keymap.set('n', '<Leader>cD', '<cmd>CMakeQuickDebug<CR>')
    vim.keymap.set('n', '<Leader>cR', '<cmd>CMakeQuickRun<CR>')
    vim.keymap.set('n', '<Leader>cscp', '<cmd>CMakeSelectConfigurePreset<CR>')
    vim.keymap.set('n', '<Leader>csl', '<cmd>CMakeSelectLaunchTarget<CR>')
    vim.keymap.set('n', '<Leader>csbp', '<cmd>CMakeSelectBuildPreset<CR>')
    vim.keymap.set('n', '<Leader>csbt', '<cmd>CMakeSelectBuildPreset<CR>')
    vim.keymap.set('n', '<Leader>cst', '<cmd>CMakeSelectTestPreset<CR>')
  end,
}
