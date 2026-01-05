-- Editor: Navigation, text objects, pairs, statusline, and utilities
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Flash (quick navigation)
  -- ════════════════════════════════════════════════════════════════════════════
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

  -- ════════════════════════════════════════════════════════════════════════════
  -- Mini.nvim (text objects, surround, pairs, statusline, icons)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
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
    end,
  },

  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Persistence (session management)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- VSCode-style diff viewer
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("vscode-diff").setup({
        highlights = {
          line_insert = "#2a3325",
          line_delete = "#362c2e",
          char_insert = "#3d4f35",
          char_delete = "#4d3538",
        },
        keymaps = {
          view = {
            next_hunk = "]c",
            prev_hunk = "[c",
            next_file = "]f",
            prev_file = "[f",
          },
          explorer = {
            select = "<CR>",
            hover = "K",
            refresh = "R",
          },
        },
      })
    end,
  },
}
