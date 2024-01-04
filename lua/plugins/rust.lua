return {
  {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
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
