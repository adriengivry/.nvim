return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      -- Default direction. Can be "left", "right", or "bottom"
      direction = 'bottom',
    },
  },
  config = function(_, opts)
    require('overseer').setup(opts)

    vim.keymap.set('n', '<leader>o', '<cmd>OverseerToggle<CR>')
    vim.keymap.set('n', '<F6>', '<cmd>OverseerRun<CR>')
    vim.keymap.set('n', '<C-/>', '<cmd>OverseerShell<CR>')
  end,
}
