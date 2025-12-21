return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    lazy = true,
    specs = {
        "folke/snacks.nvim",
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts or {}, {
                picker = {
                    actions = require("trouble.sources.snacks").actions,
                    win = {
                        input = {
                            keys = {
                                ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
                            },
                        },
                    },
                },
            })
        end,
    },
    keys = {
        -- All under <leader>d for Diagnostics
        { "<leader>dt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble (workspace)" },
        { "<leader>dT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble (buffer)" },
        { "<leader>dL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
        { "<leader>dQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
        -- LSP-related trouble views under <leader>l
        { "<leader>lt", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References (Trouble)" },
        { "<leader>lT", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    },
    config = function()
        require("trouble").setup({
            mode = "workspace_diagnostics",
            position = "bottom",
            height = 15,
            padding = false,
            action_keys = {
                close = "q",
                cancel = "<esc>",
                refresh = "r",
                jump = { "<cr>", "<tab>" },
                open_split = { "<c-x>" },
                open_vsplit = { "<c-v>" },
                open_tab = { "<c-t>" },
                jump_close = { "o" },
                toggle_mode = "m",
                toggle_preview = "P",
                hover = "K",
                preview = "p",
                close_folds = { "zM" },
                open_folds = { "zR" },
                toggle_fold = { "za" },
            },
            auto_jump = {},
            use_diagnostic_signs = true,
        })
    end,
}
