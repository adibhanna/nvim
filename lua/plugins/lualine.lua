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
local colors = {
  black        = '#1d2021',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fe8019',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

local theme = {
  normal = {
    a = { bg = colors.black, fg = colors.gray, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  insert = {
    a = { bg = colors.black, fg = colors.blue, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  visual = {
    a = { bg = colors.black, fg = colors.yellow, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  replace = {
    a = { bg = colors.black, fg = colors.red, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  command = {
    a = { bg = colors.black, fg = colors.green, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  terminal = {
    a = { bg = colors.black, fg = colors.blue, gui = 'bold' },
    b = { bg = colors.black, fg = colors.white },
    c = { bg = colors.black, fg = colors.gray }
  },
  inactive = {
    a = { bg = colors.black, fg = colors.gray, gui = 'bold' },
    b = { bg = colors.black, fg = colors.gray },
    c = { bg = colors.black, fg = colors.gray }
  }
}


return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto",
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          statusline = {
            'help',
            'startify',
            'dashboard',
            'neo-tree',
            'packer',
            'neogitstatus',
            'NvimTree',
            'Trouble',
            'alpha',
            'lir',
            'Outline',
            'spectre_panel',
            'toggleterm',
            'qf',
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          -- "filename",
          {
            "filetype",
            icon_only = true,
            separator = "",
            padding = {
              left = 1, right = 0 }
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = ""
            }
          },
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { 'diff', source = diff_source },
          { "searchcount" }
        },
        lualine_x = { { 'b:gitsigns_head', icon = '' } },
        lualine_y = { "progress" },
        lualine_z = {
          -- function()
          --   return " " .. os.date("%R")
          -- end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
