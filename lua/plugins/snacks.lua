return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
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
    -- Top-level (most used - quick access)
    -- ════════════════════════════════════════════════════════════════════
    { "<leader><space>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },

    -- Terminal
    { "<C-/>", function() Snacks.terminal() end, desc = "Terminal" },
    { "<C-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },

    -- Word navigation (LSP references)
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>b = Buffers
    -- ════════════════════════════════════════════════════════════════════
    {
      "<leader>bb",
      function()
        Snacks.picker.buffers({
          win = {
            input = { keys = { ["dd"] = "bufdelete", ["<C-d>"] = { "bufdelete", mode = { "n", "i" } } } },
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
      desc = "Switch Buffer",
    },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    { "Q", function() Snacks.bufdelete() end, desc = "Delete Buffer" },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>c = Code
    -- ════════════════════════════════════════════════════════════════════
    -- ca (code action) - defined in lsp.lua
    -- cf (format) - defined in formatting.lua
    -- cr (rename symbol) - defined in lsp.lua
    -- cd (line diagnostic) - defined in lsp.lua

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>d = Diagnostics
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>dd", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
    { "<leader>db", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>dq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>dl", function() Snacks.picker.loclist() end, desc = "Location List" },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>f = Files
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>g = Git
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Log (line)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Log (file)" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Diff (picker)" },
    { "<leader>gc", function() Snacks.picker.git_branches() end, desc = "Checkout Branch" },
    { "<leader>go", function() Snacks.gitbrowse() end, desc = "Open in Browser", mode = { "n", "v" } },
    -- GitHub
    { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "Issues" },
    { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "Issues (all)" },
    { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "Pull Requests" },
    { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "Pull Requests (all)" },
    -- Hunk operations defined in git.lua: gh, ga, gu, gr, gR, gB, gD

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>l = LSP
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Document Symbols" },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    -- li (info), lr (restart), lh (hints) - defined in lsp.lua

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>n = Notifications
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>nn", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All" },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>s = Search
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word", mode = { "n", "x" } },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>s:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>s/", function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>sr", function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume Last" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>u = UI / Toggles
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>uz", function() Snacks.zen() end, desc = "Zen Mode" },
    { "<leader>uZ", function() Snacks.zen.zoom() end, desc = "Zoom" },
    {
      "<leader>uN",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
        })
      end,
      desc = "Neovim News",
    },
    -- Other toggles defined in init function below

    -- ════════════════════════════════════════════════════════════════════
    -- <leader>w = Windows (verbose, but useful for discoverability)
    -- ════════════════════════════════════════════════════════════════════
    { "<leader>wd", "<C-w>c", desc = "Close Window" },
    { "<leader>ws", "<C-w>s", desc = "Split Horizontal" },
    { "<leader>wv", "<C-w>v", desc = "Split Vertical" },
    { "<leader>ww", "<C-w>w", desc = "Other Window" },
    { "<leader>w=", "<C-w>=", desc = "Equal Size" },
    { "<leader>wm", function() Snacks.zen.zoom() end, desc = "Maximize" },

    -- ════════════════════════════════════════════════════════════════════
    -- g = Goto (LSP navigation via Snacks picker)
    -- ════════════════════════════════════════════════════════════════════
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Debug globals
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
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
