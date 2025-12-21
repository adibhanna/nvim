return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        delay = 300,
        sort = { "alphanum", "local", "order", "group", "mod" },
        icons = {
            rules = false,
            breadcrumb = " ",
            separator = " ",
            group = "",
        },
        plugins = {
            spelling = { enabled = false },
        },
        win = {
            height = { max = math.huge },
        },
        spec = {
            mode = { "n", "v" },
            -- ════════════════════════════════════════════════════════════
            -- Main groups (alphabetical)
            -- ════════════════════════════════════════════════════════════
            { "<leader>a", group = "AI" },
            { "<leader>b", group = "Buffers" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Diagnostics/Debug" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "LSP" },
            { "<leader>s", group = "Search" },
            { "<leader>u", group = "UI" },
            { "<leader>w", group = "Windows" },
            -- ════════════════════════════════════════════════════════════
            -- Navigation groups
            -- ════════════════════════════════════════════════════════════
            { "[", group = "Prev" },
            { "]", group = "Next" },
            { "g", group = "Goto" },
            -- Hidden (standalone keymaps)
            { "<leader>v", hidden = true },
        },
    },
    keys = {
        { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Keymaps (buffer)" },
    },
}
