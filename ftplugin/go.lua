local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}
local mappings = {
  l = {
    f = { "<cmd>GoFmt<cr>", "Format (GoFmt)" },
  },
  g = {
    name = "+Go",
    s = {
      name = "+Stuct",
      j = { "<cmd> GoTagAdd json <CR>", "Add json tag" },
      y = { "<cmd> GoTagAdd yaml <CR>", "Add yaml tag" },
      J = { "<cmd> GoTagRm json <CR>", "Remove json tag" },
      Y = { "<cmd> GoTagRm yaml <CR>", "Remove yaml tag" },
    },
    t = { "<cmd>GoMod tidy<cr>", "go mod tidy" },
    e = { "<cmd>GoIfErr<cr>", "Generate if err" },
  },
}

which_key.register(mappings, opts)
