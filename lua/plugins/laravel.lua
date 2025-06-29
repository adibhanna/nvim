return {
  {
    -- 'adibhanna/laravel.nvim',
    dir = "~/Developer/opensource/laravel.nvim",
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
    dir = "~/Developer/opensource/phprefactoring.nvim",
    -- 'adibhanna/phprefactoring.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    ft = 'php',
    config = function()
      require('phprefactoring').setup({
        ui = {
          use_floating_menu = true,
          border = 'rounded',
          width = 45,
        },
        refactor = {
          show_preview = true,
          confirm_destructive = true,
          auto_format = true,
        },
        lsp = {
          use_lsp_rename = true,
          preferred_clients = { 'intelephense', 'phpactor', 'psalm' },
        },
      })
    end,
  }
}
