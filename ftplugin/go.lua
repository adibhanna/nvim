local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}
local wk = require("which-key")
wk.add({
    { "<leader>gc", ":GoCmt<CR>",      desc = "Go: Comment" },
    { "<leader>tf", ":GoTestFile<CR>", desc = "Go: Test File" },
    { "<leader>tm", ":GoTestFunc<CR>", desc = "Go: Test Function" },
})
