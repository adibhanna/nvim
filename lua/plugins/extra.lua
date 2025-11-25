return {
  -- Autotags
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  -- useful when there are embedded languages in certain types of files (e.g. Vue or React)
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },

  -- Neovim plugin to improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    config = function()
      require("dressing").setup()
    end,
  },

  -- Neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
  },

  -- find and replace
  {
    "windwp/nvim-spectre",
    enabled = true,
    event = "BufRead",
    keys = {
      {
        "<leader>Rr",
        function()
          require("spectre").open()
        end,
        desc = "Replace",
      },
      {
        "<leader>Rw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace Word",
      },
      {
        "<leader>Rf",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace Buffer",
      },
    },
  },

  -- Heuristically set buffer options
  {
    "tpope/vim-sleuth",
  },

  -- editor config support
  {
    "editorconfig/editorconfig-vim",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  -- persist sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()

      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = false,
      })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- Set all statusline sections to use one color
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { link = "StatusLine" })
      -- vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { link = "StatusLine" })
    end,
  },

  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("vscode-diff").setup({
        highlights = {
          -- Yukinord-compatible diff colors
          -- Line backgrounds: subtle, blended with yukinord's bg
          line_insert = "#2a3325", -- green-tinted bg based on yukinord green #a3be8c
          line_delete = "#362c2e", -- red-tinted bg based on yukinord red #bf616a
          -- Character highlights: more saturated versions
          char_insert = "#3d4f35", -- deeper green for inserted chars
          char_delete = "#4d3538", -- deeper red for deleted chars
        },

        keymaps = {
          view = {
            next_hunk = "]c", -- Jump to next change
            prev_hunk = "[c", -- Jump to previous change
            next_file = "]f", -- Next file in explorer mode
            prev_file = "[f", -- Previous file in explorer mode
          },
          explorer = {
            select = "<CR>", -- Open diff for selected file
            hover = "K", -- Show file diff preview
            refresh = "R", -- Refresh git status
          },
        },
      })
    end,
  },
}
