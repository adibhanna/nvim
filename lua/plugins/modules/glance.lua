return {
    "dnlhc/glance.nvim",
    config = function()
        require("glance").setup({
            -- your configuration
        })
    end,
    keys = {
        { "gD", "<CMD>Glance definitions<CR>",      desc = "Glance definitions" },
        { "gR", "<CMD>Glance references<CR>",       desc = "Glance references" },
        { "gY", "<CMD>Glance type_definitions<CR>", desc = "Glance type_definitions" },
        { "gM", "<CMD>Glance implementations<CR>", desc = "Glance implementations"}
    }
}
