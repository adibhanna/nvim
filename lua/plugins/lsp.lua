return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
    { "b0o/schemastore.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })
    require("mason-lspconfig").setup()
    require("lspconfig.ui.windows").default_options.border = "single"

    require("neodev").setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(require("config.lsp.servers")),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = require("config.lsp.on_attach").on_attach,
          settings = require("config.lsp.servers")[server_name],
          filetypes = (require("config.lsp.servers")[server_name] or {}).filetypes,
        })
      end,
    })

    vim.diagnostic.config({
      title = false,
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        source = "always",
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
      },
    })

    -- set sign icons
    vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })
  end,
}
