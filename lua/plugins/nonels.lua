return {
  {
    "nvimtools/none-ls.nvim",
    priority = 100,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
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
          -- null_ls.builtins.diagnostics.protolint,
          null_ls.builtins.completion.spell,
        },
      })
    end,
  },
}
