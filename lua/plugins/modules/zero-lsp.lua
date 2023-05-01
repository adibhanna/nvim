return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = false,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            -- inlay hints
            {
                'simrat39/inlay-hints.nvim',
                config = function()
                    require("inlay-hints").setup({
                        only_current_line = false,
                        eol = {
                            right_align = false,
                        }
                    })
                end
            },
        },
        config = function()
            local lsp = require('lsp-zero').preset("recommended")
            -- local ih = require('inlay-hints')

            lsp.ensure_installed({
                'tsserver',
                'eslint',
                'rust_analyzer',
                'gopls',
                'bashls',
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            require('lspconfig').gopls.setup({
                -- on_attach = function(client, bufnr)
                --     ih.on_attach(client, bufnr)
                -- end,
                settings = {
                    gopls = {
                        usePlaceholders = true,
                        gofumpt = true,
                        analyses = {
                            nilness = true,
                            unusedparams = true,
                            unusedwrite = true,
                            useany = true,
                        },
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
                        experimentalPostfixCompletions = true,
                        completeUnimported = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-node_modules" },
                        semanticTokens = true,
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                }
            })

            require('lspconfig').eslint.setup({
                filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
                settings = {
                    format = { enable = true },
                    lint = { enable = true },
                },
            })

            lsp.skip_server_setup({ 'rust_analyzer' })

            lsp.setup()
        end
    },
    {
        "simrat39/rust-tools.nvim",
        lazy = false,
        enabled = true,
        config = function()
            local ih = require("inlay-hints")
            -- ih.setup()
            require("rust-tools").setup({
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                            },
                            lens = {
                                enable = true,
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                },
                tools = {
                    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
                    reload_workspace_from_cargo_toml = true,
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = false,
                        only_current_line = false,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "<-",
                        other_hints_prefix = "=>",
                        max_len_align = false,
                        max_len_align_padding = 1,
                        right_align = false,
                        right_align_padding = 7,
                        highlight = "Comment",
                    },
                    hover_actions = {
                        border = "rounded",
                    },
                    on_initialized = function()
                        ih.set_all()

                        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                            pattern = { "*.rs" },
                            callback = function()
                                local _, _ = pcall(vim.lsp.codelens.refresh)
                            end,
                        })
                    end,
                },
            })
        end,
    },
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = "rounded",
                },
            }
        end,
    },
    {
        "olexsmir/gopher.nvim",
        dependencies = {
            "leoluz/nvim-dap-go"
        },
        lazy = false,
        config = function()
            local gopher = require("gopher")
            gopher.setup({
                commands = {
                    go = "go",
                    gomodifytags = "gomodifytags",
                    gotests = "gotests",
                    impl = "impl",
                    iferr = "iferr",
                },
                goimport = "gopls",
                gofmt = "gopls",
            })
        end
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }

}
