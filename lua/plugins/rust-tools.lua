local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end
return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    ft = { "rust", "rs" },
    opts = function()
      return {
        tools = {
          executor = require("rust-tools.executors").termopen,
          autoSetHints = true,
          runnables = {
            use_telescope = true,
          },
          reload_workspace_from_cargo_toml = true,
          on_initialized = function()
            vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
          end,
          inlay_hints = {
            auto = false,
          },
        },
        server = {
          on_attach = lsp.on_attach,
          capabilities = lsp.capabilities,
          standalone = false,
        },
      }
    end
  },
  -- crates
  {
    "saecki/crates.nvim",
    enabled = true,
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
}
