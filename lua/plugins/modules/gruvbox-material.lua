return {
    {
        'sainnhe/gruvbox-material',
        enabled = false,
        priority = 1000,
        config = function()
                vim.o.background = "dark"
                vim.g.gruvbox_material_background = "hard"
                vim.cmd.colorscheme 'gruvbox-material'
        end,
    },
}
