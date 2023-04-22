-- -- function to reload config
-- local function reload_nvim_config()
--     print("Reloading config...")
--     vim.cmd("source $MYVIMRC")
-- end

return {
    mode = { "n", "v" },
    [";"] = { ":Alpha<CR>", "Dashboard" },
    w = { ":w!<CR>", "Save" },
    q = { ":confirm q<CR>", "Quit" },
    c = { ":bd<CR>", "Close Buffer" },
    h = { ":nohlsearch<CR>", "No Highlight" },
    b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
        e = {
            "<cmd>BufferLinePickClose<cr>",
            "Pick which buffer to close",
        },
        h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
        l = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right",
        },
        D = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "Sort by directory",
        },
        L = {
            "<cmd>BufferLineSortByExtension<cr>",
            "Sort by language",
        },
        p = { "<cmd>BufferLineTogglePin<CR>", "Toggle pin" },
        P = { "<cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" },
    },
    -- n = {
    --     name = "Neovimmmm",
    --     r = { reload_nvim_config, "Reload Config" },
    -- }
}