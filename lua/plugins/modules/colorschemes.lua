return {
  {
    "catppuccin/nvim",
    enabled = true,
    priority = 150,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        color_overrides = {
          mocha = {
            rosewater = "#EA6962",
            flamingo = "#EA6962",
            pink = "#D3869B",
            mauve = "#D3869B",
            red = "#EA6962",
            maroon = "#EA6962",
            peach = "#BD6F3E",
            yellow = "#D8A657",
            green = "#A9B665",
            teal = "#89B482",
            sky = "#89B482",
            sapphire = "#89B482",
            blue = "#7DAEA3",
            lavender = "#7DAEA3",
            text = "#D4BE98",
            subtext1 = "#BDAE8B",
            subtext0 = "#A69372",
            overlay2 = "#8C7A58",
            overlay1 = "#735F3F",
            overlay0 = "#958272",
            surface2 = "#4B4F51",
            surface1 = "#2A2D2E",
            surface0 = "#232728",
            base = "#1D2021",
            mantle = "#191C1D",
            crust = "#151819",
          },
        },
        styles = {
          comments = { "italic" },
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        transparent_background = false,
        show_end_of_buffer = false,
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.crust },
            FloatBorder = { bg = colors.crust, fg = colors.crust },
            VertSplit = { bg = colors.base, fg = colors.surface0 },
            CursorLineNr = { fg = colors.surface2 },
            Pmenu = { bg = colors.crust, fg = "" },
            PmenuSel = { bg = colors.surface0, fg = "" },
            -- TelescopeSelection = { bg = colors.surface0 },
            -- TelescopePromptCounter = { fg = colors.mauve },
            -- TelescopePromptPrefix = { bg = colors.surface0 },
            -- TelescopePromptNormal = { bg = colors.surface0 },
            -- TelescopeResultsNormal = { bg = colors.mantle },
            -- TelescopePreviewNormal = { bg = colors.crust },
            -- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
            -- TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
            -- TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
            -- TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
            -- TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
            -- TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
            IndentBlanklineChar = { fg = colors.surface0 },
            IndentBlanklineContextChar = { fg = colors.surface2 },
            GitSignsChange = { fg = colors.peach },
            NvimTreeIndentMarker = { link = "IndentBlanklineChar" },
            NvimTreeExecFile = { fg = colors.text },
            IlluminatedWordText = { bg = colors.surface1, fg = "" },
            IlluminatedWordRead = { bg = colors.surface1, fg = "" },
            IlluminatedWordWrite = { bg = colors.surface1, fg = "" },
          }
        end,
      })

      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    priority = 500,
    config = function()
      -- vim.o.background = "dark"
      -- vim.g.gruvbox_material_background = "hard"
      -- vim.g.gruvbox_material_transparent_background = 1
      -- vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    "ChristianChiarulli/onedark.nvim",
    enabled = false,
    config = function()
      -- vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- ...
      })

      -- vim.cmd('colorscheme github_light_colorblind')
    end,
  },
  {
    'sainnhe/everforest',
    enabled = false,
    priority = 1000,
    config = function()
      -- vim.o.background = 'dark'
      -- vim.g.everforest_background = 'hard'
      -- vim.g.everforest_better_performance = 1
      --
      -- vim.cmd.colorscheme 'everforest'
    end
  },
  {
    'morhetz/gruvbox',
    enabled = false,
    priority = 1000,
    config = function()
      -- vim.o.background = 'dark'
      -- vim.g.gruvbox_bold = 0
      -- vim.g.gruvbox_italic = 0
      -- vim.g.gruvbox_italicize_comments = 0
      -- vim.g.gruvbox_contrast_dark = 'hard'
      -- vim.g.gruvbox_contrast_light = 'hard'
      -- vim.g.gruvbox_invert_selection = 0
      -- vim.g.gruvbox_color_column = 'bg0'
      -- vim.g.gruvbox_sign_column = 'bg0'
      -- vim.g.gruvbox_indent_guides = 0
      -- vim.g.gruvbox_transparent_background = 1
      -- vim.g.gruvbox_improved_strings = 0
      -- vim.g.grubvox_termcolors = 256
      --
      -- vim.cmd.colorscheme 'gruvbox'
    end
  }

}
