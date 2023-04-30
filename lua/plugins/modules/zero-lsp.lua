-- Docs https://github.com/VonHeikemen/lsp-zero.nvim/
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
        },
        config = function()
            local lsp = require('lsp-zero').preset("recommended")

            lsp.ensure_installed({
                'tsserver',
                'eslint',
                'rust_analyzer',
                'gopls'
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            require('lspconfig').gopls.setup({
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

            lsp.setup()
        end
    }
}
