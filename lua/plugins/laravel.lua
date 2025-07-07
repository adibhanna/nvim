return {
  {
    'adibhanna/laravel.nvim',
    -- dir = "~/Developer/opensource/laravel.nvim",
    ft = { 'php', 'blade' },
    dependencies = {
      'folke/snacks.nvim', -- Optional: for enhanced UI
    },
    config = function()
      require('laravel').setup({
        notifications = false,
        debug = false,
        keymaps = true
      })
    end,
  },

  {
    -- dir = "~/Developer/opensource/phprefactoring.nvim",
    'adibhanna/phprefactoring.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup()
    end,
  }
}
