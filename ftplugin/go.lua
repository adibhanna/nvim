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

local mappings = {
    g = {
        name = "Go",
        c = { ":GoCmt<CR>", "Go: Comment" },
    },
    t = {
        f = { ":GoTestFile<CR>", "Go: Test File" },
        m = { ":GoTestFunc<CR>", "Go: Test Function" },
    },
}

which_key.register(mappings, opts)
