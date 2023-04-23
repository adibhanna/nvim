return {
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        enabled = true,
        config = function()
            require("rust-tools").setup({
                tools = {
                    executor = require("rust-tools/executors").termopen,     -- can be quickfix or termopen
                    reload_workspace_from_cargo_toml = true,
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
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
}
