return {
    -- gopher
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
    -- go
    {
        "ray-x/go.nvim",
        enabled = false,
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
    },
}
