local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<C-Space>", ":WhichKey \\<space><cr>", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("n", "<leader><leader>", ":Telescope buffers<CR>", opts)