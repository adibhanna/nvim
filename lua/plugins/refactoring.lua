return {
    "ThePrimeagen/refactoring.nvim",
    enabled = false,
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    },
    config = function()
        require("refactoring").setup({})
    end
}
