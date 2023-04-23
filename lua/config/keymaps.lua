local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<C-Space>", ":WhichKey \\<space><cr>", opts)
