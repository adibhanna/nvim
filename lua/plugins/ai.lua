-- AI: Claude Code integration
return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
        -- All under <leader>a for AI
        { "<leader>aa", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume" },
        { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection" },
        { "<leader>at", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add File (tree)", ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" } },
        -- Diff management
        { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
        { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Diff" },
    },
}
