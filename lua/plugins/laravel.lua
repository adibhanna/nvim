return {
  'adibhanna/laravel.nvim',
  -- dir = "~/Developer/opensource/laravel.nvim",
  ft = { 'php', 'blade' },
  dependencies = {
    'folke/snacks.nvim', -- Optional: for enhanced UI
  },
  config = function()
    require('laravel').setup()
  end,
}
