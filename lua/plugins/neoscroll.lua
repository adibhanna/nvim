return {
    "karb94/neoscroll.nvim",
    config = function()
        require("neoscroll").setup({
            stop_eof = true,
            easing_function = "sine",
        })
    end,
}
