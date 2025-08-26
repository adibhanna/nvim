return {
    { "L3MON4D3/LuaSnip", keys = {} },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "supermaven-inc/supermaven-nvim",
                opts = {
                    disable_inline_completion = true, -- disables inline completion for use with cmp
                    disable_keymaps = true            -- disables built in keymaps for more manual control
                }
            },
            {
                "huijiro/blink-cmp-supermaven"
            },
        },
        -- event = "InsertEnter",
        version = "*",
        config = function()
            -- vim.cmd('highlight Pmenu guibg=none')
            -- vim.cmd('highlight PmenuExtra guibg=none')
            -- vim.cmd('highlight FloatBorder guibg=none')
            -- vim.cmd('highlight NormalFloat guibg=none')

            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "normal",
                },
                sources = {
                    -- per_filetype = {
                    --     codecompanion = { "codecompanion" },
                    -- },
                    default = { "lsp", "path", "supermaven", "snippets", "lazydev", "buffer" },
                    providers = {
                        supermaven = {
                            name = 'supermaven',
                            module = "blink-cmp-supermaven",
                            async = true
                        },
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                        -- laravel = {
                        --     name = "laravel",
                        --     module = "laravel.blink_source",
                        -- },
                        cmdline = {
                            min_keyword_length = 2,
                        },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = nil,
                        scrolloff = 1,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label",      "label_description", gap = 1 },
                                { "kind" },
                                { "source_name" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })

            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
