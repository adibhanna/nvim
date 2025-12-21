return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        notifier = { enabled = true, timeout = 3000 },
        picker = {
            enabled = true,
            sources = {
                files = { hidden = true },
                gh_issue = {},
                gh_pr = {},
            },
        },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = { notification = {} },
        gh = {},
    },
    keys = {
        -- ════════════════════════════════════════════════════════════════════
        -- Top-level (quick access)
        -- ════════════════════════════════════════════════════════════════════
        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
        { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>o", function() Snacks.picker.buffers({ win = { input = { keys = { ["dd"] = "bufdelete", ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } } }, list = { keys = { ["dd"] = "bufdelete" } } } }) end, desc = "Open Buffers" },
        { "<leader>p", function() Snacks.picker.lsp_symbols() end, desc = "Buffer Structure" },
        { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
        { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
        { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
        { "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
        { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notifications" },
        { "<leader>N", function() Snacks.win({ file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 } }) end, desc = "Neovim News" },
        { "<c-/>", function() Snacks.terminal() end, desc = "Terminal" },
        { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
        { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
        { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>b = Buffers
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>bb", function() Snacks.picker.buffers({ win = { input = { keys = { ["dd"] = "bufdelete", ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } } }, list = { keys = { ["dd"] = "bufdelete" } } } }) end, desc = "Switch Buffer" },
        { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
        { "Q", function() Snacks.bufdelete() end, desc = "Delete Buffer" },

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>c = Code
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
        -- cf (format) defined in conform.lua
        -- ca (code action) defined in lsp.lua
        -- cr (rename symbol) defined in lsp.lua

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>d = Diagnostics / Debug
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>dd", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
        { "<leader>dD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
        { "<leader>dq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
        { "<leader>dl", function() Snacks.picker.loclist() end, desc = "Location List" },
        -- Debug keybindings defined in dap.lua

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>f = Find / Files
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
        { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files" },
        { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Git Files" },
        { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>g = Git
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Log" },
        { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Log (line)" },
        { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Log (file)" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Status" },
        { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Stash" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Diff" },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Browse (GitHub)", mode = { "n", "v" } },
        { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "Issues" },
        { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "Issues (all)" },
        { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "Pull Requests" },
        { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "Pull Requests (all)" },
        -- Hunk operations defined in git.lua

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>l = LSP
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
        { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
        -- Other LSP keybindings defined in lsp.lua

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>s = Search
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>ss", function() Snacks.picker.grep() end, desc = "Grep" },
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word", mode = { "n", "x" } },
        { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
        { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
        { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
        { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
        { "<leader>sk", function() Snacks.picker.keymaps({ layout = "select" }) end, desc = "Keymaps" },
        { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
        { "<leader>sC", function() Snacks.picker.command_history() end, desc = "Command History" },
        { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
        { "<leader>sr", function() Snacks.picker.registers() end, desc = "Registers" },
        { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
        { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
        { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
        { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
        { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Plugins" },
        { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notifications" },
        { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
        { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume Last" },
        { "<C-s>", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>u = UI / Toggle
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
        { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
        -- Other toggles defined in init function below

        -- ════════════════════════════════════════════════════════════════════
        -- <leader>w = Windows
        -- ════════════════════════════════════════════════════════════════════
        { "<leader>wd", "<C-w>c", desc = "Close Window" },
        { "<leader>ws", "<C-w>s", desc = "Split Horizontal" },
        { "<leader>wv", "<C-w>v", desc = "Split Vertical" },
        { "<leader>wh", "<C-w>h", desc = "Go Left" },
        { "<leader>wj", "<C-w>j", desc = "Go Down" },
        { "<leader>wk", "<C-w>k", desc = "Go Up" },
        { "<leader>wl", "<C-w>l", desc = "Go Right" },
        { "<leader>ww", "<C-w>w", desc = "Other Window" },
        { "<leader>w=", "<C-w>=", desc = "Equal Size" },

        -- ════════════════════════════════════════════════════════════════════
        -- g = Goto (LSP navigation via Snacks picker)
        -- ════════════════════════════════════════════════════════════════════
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
        { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Declaration" },
        { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
        { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
        { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Debug globals
                _G.dd = function(...) Snacks.debug.inspect(...) end
                _G.bt = function() Snacks.debug.backtrace() end
                vim.print = _G.dd

                -- Toggle mappings under <leader>u
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>ur")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.diagnostics():map("<leader>uD")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ui")
                Snacks.toggle.dim():map("<leader>ud")
            end,
        })
    end,
}
