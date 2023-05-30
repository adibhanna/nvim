local colors = require("config.colors").colors
return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                indicator = {
                    icon = " ",
                },
                show_close_icon = false,
                tab_size = 0,
                max_name_length = 25,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "  Project",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                modified_icon = "",
                custom_areas = {
                    left = function()
                        if vim.bo.filetype == "alpha" then
                            return {}
                        end

                        return {
                            { text = "    ", fg = colors.fg },
                        }
                    end,
                },
            },
            highlights = {
                fill = {
                    bg = "",
                },
                background = {
                    bg = "",
                },
                tab = {
                    bg = "",
                },
                tab_close = {
                    bg = "",
                },
                tab_separator = {
                    fg = colors.bg,
                    bg = "",
                },
                tab_separator_selected = {
                    fg = colors.bg,
                    bg = "",
                    sp = colors.fg,
                },
                close_button = {
                    bg = "",
                    fg = colors.fg,
                },
                close_button_visible = {
                    bg = "",
                    fg = colors.fg,
                },
                close_button_selected = {
                    fg = { attribute = "fg", highlight = "StatusLineNonText" },
                },
                buffer_visible = {
                    bg = "",
                },
                modified = {
                    bg = "",
                },
                modified_visible = {
                    bg = "",
                },
                duplicate = {
                    fg = colors.fg,
                    bg = ""
                },
                duplicate_visible = {
                    fg = colors.fg,
                    bg = ""
                },
                separator = {
                    fg = colors.bg,
                    bg = ""
                },
                separator_selected = {
                    fg = colors.bg,
                    bg = ""
                },
                separator_visible = {
                    fg = colors.bg,
                    bg = ""
                },
                offset_separator = {
                    fg = colors.bg,
                    bg = ""
                },
            },
        })
    end,
}
