return {
  'Civitasv/cmake-tools.nvim',
  opts = {
    cmake_regenerate_on_save = false,
    cmake_generate_options = {
      '-DCMAKE_EXPORT_COMPILE_COMMANDS=1',
    },
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

    local cmake_actions = {
      { desc = 'Generate', cmd = 'CMakeGenerate', group = 'Build' },
      { desc = 'Build', cmd = 'CMakeBuild', group = 'Build' },
      { desc = 'Quick Build', cmd = 'CMakeQuickBuild', group = 'Build' },
      { desc = 'Run', cmd = 'CMakeRun', group = 'Run' },
      { desc = 'Quick Run', cmd = 'CMakeQuickRun', group = 'Run' },
      { desc = 'Debug', cmd = 'CMakeDebug', group = 'Debug' },
      { desc = 'Quick Debug', cmd = 'CMakeQuickDebug', group = 'Debug' },
      { desc = 'Run Test', cmd = 'CMakeRunTest', group = 'Test' },
      { desc = 'Select Configure Preset', cmd = 'CMakeSelectConfigurePreset', group = 'Select' },
      { desc = 'Select Build Preset', cmd = 'CMakeSelectBuildPreset', group = 'Select' },
      { desc = 'Select Build Type', cmd = 'CMakeSelectBuildType', group = 'Select' },
      { desc = 'Select Test Preset', cmd = 'CMakeSelectTestPreset', group = 'Select' },
      { desc = 'Select Launch Target', cmd = 'CMakeSelectLaunchTarget', group = 'Select' },
      { desc = 'Clean', cmd = 'CMakeClean', group = 'Clean' },
    }

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
    vim.keymap.set('n', '<Leader>csbt', '<cmd>CMakeSelectBuildType<CR>')
    vim.keymap.set('n', '<Leader>cst', '<cmd>CMakeSelectTestPreset<CR>')

    vim.keymap.set('n', '<F3>', function()
      local pickers = require 'telescope.pickers'
      local finders = require 'telescope.finders'
      local conf = require('telescope.config').values
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'
      local entry_display = require 'telescope.pickers.entry_display'

      local group_hl = {
        Build = 'TelescopeResultsIdentifier',
        Run = 'DiagnosticOk',
        Debug = 'DiagnosticWarn',
        Test = 'TelescopeResultsSpecialComment',
        Select = 'TelescopeResultsConstant',
      }

      local displayer = entry_display.create {
        separator = '  ',
        items = {
          { width = 7 }, -- group label
          { remaining = true }, -- action name
        },
      }

      local make_display = function(entry)
        local g = entry.value.group
        return displayer {
          { g, group_hl[g] or 'TelescopeResultsNormal' },
          { entry.value.desc, 'TelescopeResultsNormal' },
        }
      end

      pickers
        .new({
          layout_strategy = 'center',
          layout_config = { width = 0.35, height = 0.5 },
          sorting_strategy = 'ascending',
        }, {
          prompt_title = ' CMake',
          results_title = false,
          previewer = false,
          finder = finders.new_table {
            results = cmake_actions,
            entry_maker = function(entry)
              return {
                value = entry,
                display = make_display,
                ordinal = entry.group .. ' ' .. entry.desc,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local sel = action_state.get_selected_entry()
              if sel then vim.cmd(sel.value.cmd) end
            end)
            return true
          end,
        })
        :find()
    end, { desc = 'CMake action palette' })
  end,
}
