return {
    "karb94/neoscroll.nvim",
    config = function()
        require("neoscroll").setup({
            stop_eof = true,
            easing_function = "sine",
            hide_cursor = true,
            -- respect_scrolloff = true,
            cursor_scrolls_alone = true,
            -- performance_mode = false
        })
    end,
}
