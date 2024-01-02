return {
  {
    "LunarVim/breadcrumbs.nvim",
    config = function()
      require("breadcrumbs").setup()
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local icons = require "config.icons"
      require("nvim-navic").setup {
        highlight = true,
        lsp = {
          auto_attach = true,
          preference = { "typescript-tools" },
        },
        click = true,
        separator = " " .. icons.ui.ChevronRight .. " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
      }
    end
  }
}
