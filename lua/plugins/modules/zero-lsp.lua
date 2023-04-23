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

            -- lsp.ensure_installed({
            --     'tsserver',
            --     'eslint',
            --     'rust_analyzer',
            --     'gopls'
            -- })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            -- lsp.set_sign_icons({
            --     error = '✘',
            --     warn = '▲',
            --     hint = '⚑',
            --     info = '»'
            -- })

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
       
            lsp.setup()
        end
    }
}
