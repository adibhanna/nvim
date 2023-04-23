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
            local lsp = require('lsp-zero').preset('recommended')


            lsp.ensure_installed({
                -- Replace these with whatever servers you want to install
                'tsserver',
                'eslint',
                'rust_analyzer',
                'gopls'
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.set_sign_icons({
                error = '✘',
                warn = '▲',
                hint = '⚑',
                info = '»'
            })

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            require('lspconfig').rust_analyzer.setup({
                on_attach = lsp.on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        lens = {
                          enable = true,
                        },
                        cargo = {
                          allFeatures = true,
                          loadOutDirsFromCheck = true,
                          runBuildScripts = true,
                        },
                        -- Add clippy lints for Rust.
                        check = {
                          enable = true,
                          allFeatures = true,
                          command = "clippy",
                          extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                          enable = true,
                          ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                          },
                        },
                      },
                },
            })


            lsp.setup()
        end
    }
}
