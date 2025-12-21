return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false, -- Plugin does not support lazy-loading
        config = function()
            -- New API for nvim-treesitter (Neovim 0.11+)
            require("nvim-treesitter").setup({
                ensure_install = {
                    "bash",
                    "c",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "luadoc",
                    "luap",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vue",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "rust",
                    "go",
                    "gomod",
                    "gowork",
                    "gosum",
                    "terraform",
                    "proto",
                    "zig",
                    "php",
                    "blade",
                },
            })

            -- Enable treesitter-based highlighting
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    -- textobjects removed - use mini.ai instead (already configured in extra.lua)
    -- mini.ai provides: af/if (function), ac/ic (class), etc.
}
