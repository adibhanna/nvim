return {
    {
        "akinsho/bufferline.nvim",
        enabled = true,
        event = "VimEnter",
        lazy = true,
        opts = {
            options = {
                mode = "buffers",
                numbers = "none",
                close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
                    vim.api.nvim_buf_delete(bufnr, { force = true })
                end,
                right_mouse_command = "", -- right click does nothing
                -- left_mouse_command = "",
                color_icons = true,
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                truncate_names = true,  -- whether or not tab names should be truncated
                tab_size = 18,
                show_tab_indicators = true,
                separator_style = "thin", -- "slant" | "padded_slant" | "slope" | "thick" | "thin"
                diagnostics = "nvim_lsp",
                show_close_icon = false,
                always_show_bufferline = false,
                hover = {
                    enabled = false,
                    delay = 200,
                    reveal = { "close" },
                },
                -- diagnostics_indicator = function(_, _, diag)
                --     local s = " "
                --     for e, n in pairs(diag) do
                --         local sym = e == "error" and " "
                --             or (e == "warning" and " " or "")
                --         s = s .. n .. sym
                --     end
                --     return s
                -- end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            },
        },
    },
}
