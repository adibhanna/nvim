return {
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        version = false,
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
            'telescope-dap.nvim'
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {
                defaults   = {
                    theme                = 'dropdown',
                    file_ignore_patterns = { 'node_modules', 'package-lock.json' },
                    initial_mode         = 'insert',
                    select_strategy      = 'reset',
                    sorting_strategy     = nil,
                    layout_strategy      = nil,
                    layout_config        = nil,
                    path_display         = { "smart" },
                    winblend             = 0,
                    border               = {},
                    borderchars          = nil,
                    color_devicons       = true,
                    set_env              = { ["COLORTERM"] = "truecolor" },
                    vimgrep_arguments    = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                        "--glob=!.git/",
                    },
                },
                pickers    = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        --@usage don't include the filename in the search results
                        only_sort_text = true,
                    },
                    grep_string = {
                        only_sort_text = true,
                    },
                    buffers = {
                        initial_mode = "normal",
                        -- mappings = {
                        --     i = {
                        --         ["<C-d>"] = require("telescope.actions").delete_buffer,
                        --     },
                        --     n = {
                        --         ["dd"] = require("telescope.actions").delete_buffer,
                        --     },
                        -- },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,                       -- false will only do exact matching
                        override_generic_sorter = true,     -- override the generic sorter
                        override_file_sorter = true,        -- override the file sorter
                        case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({
                            layout_strategy = "center",
                            previewer = false,
                            shorten_path = false,
                            winblend = 10,
                        })
                 
                    },
                }
            }
            telescope.load_extension('fzf')
            telescope.load_extension('ui-select')
            telescope.load_extension('refactoring')
            telescope.load_extension('dap')
        end
    },
}
