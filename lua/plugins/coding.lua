-- Coding: Completion, treesitter, and dev tools
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Completion (blink.cmp)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "default" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "lazydev", "lsp", "path", "buffer", "snippets" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        keymap = {
          ["<C-f>"] = {},
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = "rounded",
            scrolloff = 1,
            scrollbar = false,
            draw = {
              padding = 1,
              gap = 1,
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Treesitter
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "proto",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "svelte",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
        "zig",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Lua development
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Autotags for HTML/JSX
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Comments
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },
}
