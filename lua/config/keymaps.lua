vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap("n", "<C-Space>", ":WhichKey \\<space><cr>", opts)
