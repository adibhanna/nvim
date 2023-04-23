local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
  g = {
    name = "+Go",
    b = { "<cmd>GoBuild<cr>", "Build" },
    i = { "<cmd>GoInstall<cr>", "Install" },
    t = { "<cmd>GoTest<cr>", "Test" },
    r = { "<cmd>GoRun<cr>", "Run" },
    -- D = { "<cmd>GoDebugStart<cr>", "Debug (Delve)" }, -- brew install delve
    d = { "<cmd>GoDef<cr>", "Symbol/Declaration" },
    -- B = { "<cmd>GoDoc<cr>", "Documentation" },
    p = { "<cmd>GoImport<cr>", "Import Package" },
    P = { "<cmd>GoDrop<cr>", "Remove Package" },
    n = { "<cmd>GoRename<cr>", "Rename" },
    c = { "<cmd>GoCoverage<cr>", "Test Coverage" },
    -- a = { "<cmd>GoAddTags<cr>", "Add Tags" },
    -- A = { "<cmd>GoRemoveTags<cr>", "Remove Tags" },
    l = { "<cmd>GoLint<cr>", "Lint" },
    v = { "<cmd>GoVet<cr>", "Catch Static Errors" },
    e = { "<cmd>GoErrCheck<cr>", "Check Errors" },
  },
}

which_key.register(mappings, opts)
