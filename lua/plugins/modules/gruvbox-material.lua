return {
    {
        'sainnhe/gruvbox-material',
        enabled = true,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_transparent_background = 1
            vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
    {
        "ChristianChiarulli/onedark.nvim",
        config = function()
            -- vim.cmd.colorscheme 'onedark'
        end,
    }
}
