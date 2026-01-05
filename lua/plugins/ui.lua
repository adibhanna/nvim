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
      delay = 250,
      sort = { "alphanum", "local", "order", "group", "mod" },
      icons = {
        rules = false,
        breadcrumb = "»",
        separator = "→",
        group = "+",
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = false },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
      spec = {
        mode = { "n", "v" },
        -- Top-level quick access
        { "<leader><space>", desc = "Find Files" },
        { "<leader>/", desc = "Grep" },
        { "<leader>,", desc = "Buffers" },
        { "<leader>.", desc = "Scratch" },
        { "<leader>e", desc = "Explorer" },
        { "<leader>q", desc = "Quit" },
        { "<leader>Q", desc = "Quit All" },
        -- Main groups with icons
        { "<leader>b", group = "Buffers", icon = "󰈔" },
        { "<leader>c", group = "Code", icon = "" },
        { "<leader>d", group = "Diagnostics", icon = "" },
        { "<leader>f", group = "Files", icon = "󰈞" },
        { "<leader>g", group = "Git", icon = "󰊢" },
        { "<leader>gh", group = "Hunks", icon = "" },
        { "<leader>l", group = "LSP", icon = "" },
        { "<leader>m", group = "Markdown", icon = "" },
        { "<leader>n", group = "Notifications", icon = "󰈸" },
        { "<leader>s", group = "Search", icon = "" },
        { "<leader>u", group = "UI/Toggle", icon = "󰙵" },
        { "<leader>w", group = "Windows", icon = "" },
        -- Navigation groups
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        -- Surround (mini.surround)
        { "gs", group = "Surround" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps" },
      { "<leader>K", function() require("which-key").show({ global = true }) end, desc = "All Keymaps" },
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
  -- Markdown Preview (browser-based with mermaid support)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_theme = "dark"
      -- Enable mermaid, katex, and other features
      vim.g.mkdp_preview_options = {
        mermaid = { theme = "dark" },
        katex = {},
        disable_sync_scroll = 0,
        sync_scroll_type = "middle",
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
      }
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Render Markdown (in-buffer rendering)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    opts = {
      heading = {
        enabled = true,
        sign = false,
        icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
      },
      code = {
        enabled = true,
        sign = false,
        style = "full",
        left_pad = 1,
        right_pad = 1,
        border = "thin",
        language_pad = 1,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "☐ " },
        checked = { icon = "☑ " },
      },
      quote = { enabled = true, icon = "▎" },
      pipe_table = { enabled = true, style = "full" },
      callout = {
        note = { raw = "[!NOTE]", rendered = " Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = " Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = " Caution", highlight = "RenderMarkdownError" },
      },
    },
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown Toggle", ft = "markdown" },
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
