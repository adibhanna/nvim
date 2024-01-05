return {
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   {
    --     "lvimuser/lsp-inlayhints.nvim",
    --     opts = {}
    --   },
    -- },
    -- config = function()
    --   vim.g.rustaceanvim = {
    --     inlay_hints = {
    --       highlight = "NonText",
    --     },
    --     tools = {
    --       hover_actions = {
    --         auto_focus = true,
    --       },
    --     },
    --     server = {
    --       on_attach = function(client, bufnr)
    --         require("lsp-inlayhints").on_attach(client, bufnr)
    --       end
    --     }
    --   }
    -- end
  },
  -- crates
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    lazy = true,
    ft = { "rust", "toml" },
    event = { "BufRead", "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        -- null_ls = {
        --   enabled = true,
        --   name = "crates.nvim",
        -- },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    'vxpm/ferris.nvim',
    opts = {
      -- If true, will automatically create commands for each LSP method
      create_commands = true,     -- bool
      -- Handler for URL's (used for opening documentation)
      url_handler = "xdg-open",   -- string | function(string)
    }
  }
}
