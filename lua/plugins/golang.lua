return {
    -- gopher
    {
        "olexsmir/gopher.nvim",
        enabled = false,
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
    -- go
    {
        "ray-x/go.nvim",
        enabled = true,
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
            "leoluz/nvim-dap-go"
        },
        config = function()
            require("go").setup({
                lsp_inlay_hints = {
                    enable = false
                }
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
}
