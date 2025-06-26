return {
    "adibhanna/nvim-newfile.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
        require("nvim-newfile").setup({
            notifications = {
                enabled = false, -- Set to false to disable file creation notifications
            },
        })
    end,
}
