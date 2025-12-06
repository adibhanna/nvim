return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            -- ============================================================================
            -- LSP Keymaps Setup
            -- ============================================================================
            local function setup_keymaps(bufnr)
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
                end

                -- Navigation
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                map("n", "gr", vim.lsp.buf.references, "Go to references")
                map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

                -- Information
                map("n", "K", vim.lsp.buf.hover, "Hover documentation")
                map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
                map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

                -- Code actions
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                -- Format keybinding handled by conform.nvim plugin
                -- map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

                -- Diagnostics
                map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
                map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
                map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
                map("n", "<leader>cl", vim.diagnostic.setloclist, "Diagnostics to loclist")

                -- Workspace
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "List workspace folders")

                -- Inlay hints toggle (useful for manual control)
                if vim.lsp.inlay_hint then
                    map("n", "<leader>ih", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
                    end, "Toggle inlay hints")
                end
            end

            -- ============================================================================
            -- LSP Attach Handler
            -- ============================================================================
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    if not client then return end

                    -- Setup keymaps for this buffer
                    setup_keymaps(bufnr)

                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Enable inlay hints if supported (Neovim 0.10+)
                    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end

                    -- Document highlight on cursor hold
                    if client.server_capabilities.documentHighlightProvider then
                        local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr,
                            { clear = true })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = bufnr,
                            group = highlight_group,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = bufnr,
                            group = highlight_group,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })

            -- ============================================================================
            -- Diagnostic Configuration
            -- ============================================================================
            vim.diagnostic.config({
                virtual_text = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = "",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                    },
                },
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        lazy = false,
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local lspconfig = require("lspconfig")

            -- Default handler for servers without custom config
            local function default_setup(server_name)
                lspconfig[server_name].setup({})
            end

            -- Custom handlers for servers with specific config
            local handlers = {
                -- Default handler
                default_setup,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" },
                                    disable = { "inject-field", "undefined-field", "missing-fields" },
                                },
                                runtime = {
                                    version = "LuaJIT",
                                },
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    },
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,

                ["intelephense"] = function()
                    local get_intelephense_license = function()
                        local f = assert(io.open(os.getenv("HOME") .. "/intelephense/license.txt", "rb"))
                        local content = f:read("*a")
                        f:close()
                        return string.gsub(content, "%s+", "")
                    end

                    lspconfig.intelephense.setup({
                        cmd = { "intelephense", "--stdio" },
                        filetypes = { "php", "blade" },
                        root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
                        init_options = {
                            licenceKey = get_intelephense_license(),
                        },
                    })
                end,
            }

            -- Setup mason-lspconfig with handlers
            mason_lspconfig.setup({
                handlers = handlers,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Language Servers
                    "lua_ls",
                    "gopls",
                    "zls",
                    "ts_ls",
                    "rust-analyzer",
                    "intelephense",
                    "bashls",
                    "pyright",
                    "cssls",
                    "html",
                    "jsonls",
                    "yamlls",

                    -- Linters
                    "eslint_d",
                    "luacheck",
                    "golangci-lint",
                    "shellcheck",
                    "markdownlint",
                    "yamllint",
                    "jsonlint",
                    "htmlhint",
                    "stylelint",
                    "phpstan",
                    "ruff",
                    "mypy",

                    -- Formatters
                    "stylua",
                    "goimports",
                    "prettier",
                    "black",
                    "isort",
                    "shfmt",
                    "pint",
                },
            })
        end,
    }
}
