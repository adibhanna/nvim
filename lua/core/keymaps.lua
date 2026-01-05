-- ════════════════════════════════════════════════════════════════════════════
-- Essential Operations
-- ════════════════════════════════════════════════════════════════════════════

-- Save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set({ "i", "x" }, "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save File" })

-- Quit
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight", silent = true })

-- ════════════════════════════════════════════════════════════════════════════
-- Window Navigation (no prefix for speed)
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go Right" })

-- Window resizing
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- ════════════════════════════════════════════════════════════════════════════
-- Line Movement (Visual Mode)
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- ════════════════════════════════════════════════════════════════════════════
-- Better Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- Wrapped line navigation
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (wrapped)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (wrapped)" })

-- Start/End of line (easier than ^ and $)
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- ════════════════════════════════════════════════════════════════════════════
-- Better Editing
-- ════════════════════════════════════════════════════════════════════════════

-- Better indenting (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- Paste over selection without yanking
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- Yank block
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- Split line (opposite of J)
vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { desc = "Split Line", silent = true })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- ════════════════════════════════════════════════════════════════════════════
-- Insert Mode Escapes
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert" })

-- ════════════════════════════════════════════════════════════════════════════
-- Terminal Mode
-- ════════════════════════════════════════════════════════════════════════════

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go Left" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go Down" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go Up" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go Right" })
