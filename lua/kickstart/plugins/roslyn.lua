return {
  'seblyng/roslyn.nvim',
  ft = 'cs',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('roslyn').setup {
      filewatching = 'roslyn',
    }
  end,
}
