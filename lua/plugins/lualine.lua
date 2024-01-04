local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    local icons = require('config.icons')
    require("lualine").setup {
      options = {
        theme = 'catppuccin',
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = icons.ui.DividerRight, right = icons.ui.DividerLeft },
        section_separators = '',
        disabled_filetypes = {
          statusline = {
            'alfa-nvim',
            'help',
            'neo-tree',
            'Trouble',
            'spectre_panel',
            'toggleterm',
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 2 for full path
            symbols = {
              modified = "  ",
              -- readonly = "  ",
              -- unnamed = "  ",
            }
          },
          -- {
          --   "aerial",
          --   sep = " ) ",
          --   depth = nil,
          --   dense = true,
          --   dense_sep = ".",
          --   colored = false,
          -- },
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "searchcount" },
        },
        lualine_x = {
          { 'b:gitsigns_head', icon = '' },
          { 'diff', source = diff_source },
          "progress"
        },
        lualine_y = {
        },
        lualine_z = {
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        -- lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
