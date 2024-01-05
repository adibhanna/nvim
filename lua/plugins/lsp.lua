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
    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          -- apply whatever logic you want (in this example, we'll only use null-ls)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end

    -- if you want to set up formatting on save, you can use this as a callback
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end

      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("go", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      nmap("gl", vim.diagnostic.open_float, "Open Diagnostic Float")

      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("gs", vim.lsp.buf.signature_help, "Signature Documentation")

      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")
    end

    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })
    require("mason-lspconfig").setup()
    require("lspconfig.ui.windows").default_options.border = "single"

    local servers = {
      jsonls = {
        settings = {
          json = {
            schema = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      terraformls = {
        cmd = { "terraform-ls" },
        arg = { "server" },
        filetypes = { "terraform", "tf", "terraform-vars" },
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      bashls = {
        filetypes = { "sh", "zsh" },
      },
      vimls = {
        filetypes = { "vim" },
      },
      -- tsserver = {
      --   filetypes = {
      --     "javascript",
      --     "javascriptreact",
      --     "javascript.jsx",
      --     "typescript",
      --     "typescriptreact",
      --     "typescript.tsx",
      --   },
      -- },
      gopls = {},
    }

    require("neodev").setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
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
