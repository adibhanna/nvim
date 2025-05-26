return {
    {
        "olimorris/codecompanion.nvim",
        opts = {
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        keymap = "gh",
                        auto_generate_title = true,
                        continue_last_chat = false,
                        delete_on_clearing_chat = false,
                        picker = "snacks",
                        enable_logging = false,
                        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                    },
                },
                -- mcphub = {
                --   callback = "mcphub.extensions.codecompanion",
                --   opts = {
                --     make_vars = true,
                --     make_slash_commands = true,
                --     show_result_in_chat = true,
                --   },
                -- },
                vectorcode = {
                    opts = {
                        add_tool = true,
                    },
                },
            },
            adapters = {
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "gemini-2.5-pro",
                            },
                        },
                    })
                end,
            }
        },
        keys = {
            { "<leader>ic", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" },
            { "<leader>iC", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
            { "<leader>ia", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
            { "<leader>id", "<cmd>CodeCompanionCmd<cr>", desc = "CodeCompanion CMD" },
        },
        dependencies = {
            "j-hui/fidget.nvim",
            "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            -- {
            --     "Davidyz/VectorCode", -- Index and search code in your repositories
            --     version = "*",
            --     build = "pipx upgrade vectorcode",
            --     dependencies = { "nvim-lua/plenary.nvim" },
            -- },
        },
        config = function()
            require("codecompanion").setup({
                strategies = {
                    chat = {
                        adapter = "copilot",
                    },
                    inline = {
                        adapter = "copilot",
                    },
                    cmd = {
                        adapter = "copilot",
                    }
                },
                display = {
                    action_palette = {
                        width = 95,
                        height = 10,
                        prompt = "Prompt ",       -- Prompt used for interactive LLM calls
                        provider = "snacks",      -- Can be "default", "telescope", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                        opts = {
                            show_default_actions = true, -- Show the default actions in the action palette?
                            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                        },
                    },
                },
            })
        end
    },
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_next = "<c-j>",
                        jump_prev = "<c-k>",
                        accept = "<c-a>",
                        refresh = "r",
                        open = "<M-CR>",
                    },
                    layout = {
                        position = "bottom", -- | top | left | right
                        ratio = 0.4,
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    keymap = {
                        accept = "<c-a>",
                        accept_word = false,
                        accept_line = false,
                        next = "<c-j>",
                        prev = "<c-k>",
                        dismiss = "<C-e>",
                    },
                },
            })
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                            -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}
