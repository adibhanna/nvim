-- TODO

-- references:
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>e", ":Neotree toggle<CR>", silent = true , desc = "File Explorer"},
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                position = "left",
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        --auto close
                        require("neo-tree").close_all()
                    end,
                },
            },
        })
    end,
}
