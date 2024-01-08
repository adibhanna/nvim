return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",

      "leoluz/nvim-dap-go",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("go").setup({
        capabilities = capabilities,
        lsp_on_attach = require("plugins.lsp.on_attach").on_attach,
        lsp_cfg = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        luasnip = true,
      })

      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.diagnostics.revive,
        null_ls.builtins.formatting.golines.with({
          extra_args = {
            "--max-len=180",
            "--base-formatter=gofumpt",
          },
        }),
      }
      -- for go.nvim
      -- local gotest = require("go.null_ls").gotest()
      -- local gotest_codeaction = require("go.null_ls").gotest_action()
      -- local golangci_lint = require("go.null_ls").golangci_lint()
      -- table.insert(sources, gotest)
      -- table.insert(sources, golangci_lint)
      -- table.insert(sources, gotest_codeaction)
      -- null_ls.setup({ sources = sources, debounce = 1000, default_timeout = 5000 })

      -- alternatively
      -- null_ls.register(gotest)
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
