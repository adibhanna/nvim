-- UI: Which-key, diagnostics display, notifications, and visual enhancements
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Which-key (keybinding help)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 300,
      sort = { "alphanum", "local", "order", "group", "mod" },
      icons = {
        rules = false,
        breadcrumb = " ",
        separator = " ",
        group = "",
      },
      plugins = {
        spelling = { enabled = false },
      },
      win = {
        height = { max = math.huge },
      },
      spec = {
        mode = { "n", "v" },
        -- Main groups (alphabetical)
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Diagnostics/Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "UI" },
        { "<leader>w", group = "Windows" },
        -- Navigation groups
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        -- Hidden (standalone keymaps)
        { "<leader>v", hidden = true },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Keymaps (buffer)" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Inline diagnostics (prettier diagnostic display)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = false,
        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },
        options = {
          show_source = { enabled = false, if_many = false },
          use_icons_from_diagnostic = false,
          set_arrow_to_diag_color = false,
          add_messages = true,
          throttle = 20,
          softwrap = 30,
          multilines = { enabled = false, always_show = false },
          show_all_diags_on_cursorline = false,
          enable_on_insert = false,
          enable_on_select = false,
          overflow = { mode = "wrap", padding = 0 },
          break_line = { enabled = false, after = 30 },
          format = nil,
          virt_texts = { priority = 2048 },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
        disabled_ft = {},
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Fidget (LSP progress notifications)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Trouble (better diagnostics list)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
                },
              },
            },
          },
        })
      end,
    },
    keys = {
      { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" },
      { "<leader>dT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble (buffer)" },
      { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
      { "<leader>lt", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References (Trouble)" },
      { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    config = function()
      require("trouble").setup({
        mode = "workspace_diagnostics",
        position = "bottom",
        height = 15,
        padding = false,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM" },
          open_folds = { "zR" },
          toggle_fold = { "za" },
        },
        auto_jump = {},
        use_diagnostic_signs = true,
      })
    end,
  },

}
