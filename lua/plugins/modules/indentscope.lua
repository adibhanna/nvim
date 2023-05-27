return {
    "echasnovski/mini.indentscope",
    enabled = false,
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- symbol = "▏",
        symbol = "│",
        options = { try_as_border = true },
    },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
    config = function(_, opts)
        require("mini.indentscope").setup(opts)
    end,
}
