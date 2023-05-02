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
  l = {
    f = { "<cmd>GoFmt<cr>", "Format (GoFmt)" },
  },
  g = {
    name = "+Go",
    i = { "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies" },
    o = { "<cmd>GoPkgOutline<cr>", "Outline" },
    I = { "<cmd>GoToggleInlay<cr>", "Toggle inlay" },
    -- l = { "<cmd>GoLint<cr>", "Run linter" },
    g = { "<cmd>GoGenerate<Cr>", "Go Generate" },
    G = { "<cmd>GoGenerate %<Cr>", "Go Generate File" },
    c = { "<cmd>GoCmt<Cr>", "Generate Comment" },
    s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
    j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
    h = {
      name = "Helper",
      a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
      r = { "<cmd>GoRMTag<cr>", "Remove tags to struct" },
      c = { "<cmd>GoCoverage<cr>", "Test coverage" },
      v = { "<cmd>GoVet<cr>", "Go vet" },
      t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
      i = { "<cmd>GoModInit<cr>", "Go mod init" },
    },
    t = {
      name = "Tests",
      r = { "<cmd>GoTest<cr>", "Run tests" },
      a = { "<cmd>GoAlt!<cr>", "Open alt file" },
      s = { "<cmd>GoAltS!<cr>", "Open alt file in split" },
      v = { "<cmd>GoAltV!<cr>", "Open alt file in vertical split" },
      u = { "<cmd>GoTestFunc<cr>", "Run test for current func" },
      f = { "<cmd>GoTestFile<cr>", "Run test for current file" },
      T = { "<cmd>GoTestAdd<Cr>", "Add Test" },
      A = { "<cmd>GoTestsAll<Cr>", "Add All Tests" },
      e = { "<cmd>GoTestsExp<Cr>", "Add Exported Tests" },
    },
    x = {
      name = "Code Lens",
      l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
      a = { "<cmd>GoCodeAction<cr>", "Code Action" },
    },
  },
}

which_key.register(mappings, opts)
