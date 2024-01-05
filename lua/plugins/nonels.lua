return {
  {
    "nvimtools/none-ls.nvim",
    priority = 100,
    -- "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      --   "nvimtools/none-ls.nvim",
    },
    config = function()
      --   require("mason-null-ls").setup({
      --     ensure_installed = {
      --       "stylua",
      --       "eslint_d",
      --       "prettier",
      --       "golangci_lint",
      --       "gofumpt",
      --       "terraform_fmt",
      --       "terraform_validate"
      --     },
      --     automatic_installation = false,
      --     handlers = {},
      --   })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.buf,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.protolint,
        },
      })
    end,
  },
}
