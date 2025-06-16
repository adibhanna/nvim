return {
    {
        "williamboman/mason.nvim",
        lazy = false, -- Load immediately to ensure PATH is set
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- LSP servers (matching your vim.lsp.enable() config)
                "lua-language-server",
                "gopls",
                "zls",
                "typescript-language-server",
                "rust-analyzer",
                "intelephense", -- PHP LSP

                -- Formatters (for conform.nvim and general use)
                "stylua",
                "goimports",
                -- Note: gofmt comes with Go installation, not managed by Mason
                "prettier",
                "black",
                "isort",

                -- Linters and diagnostics
                "golangci-lint",
                "eslint_d",
                "luacheck", -- Lua linting
                "pint",     -- Laravel Pint for PHP (formatting & linting)

                -- Additional useful tools
                "delve",      -- Go debugger
                "shfmt",      -- Shell formatter
                "shellcheck", -- Shell linter
            },
        },
        config = function(_, opts)
            -- PATH is handled by core.mason-path for consistency
            require("mason").setup(opts)

            -- Auto-install ensure_installed tools
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        print("Mason: Installing " .. tool .. "...")
                        p:install()
                    end
                end
            end

            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
