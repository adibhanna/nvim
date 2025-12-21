-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- Remap for dealing with visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "Up (wrapped)" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = "Down (wrapped)" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp', { desc = "Paste (no yank)" })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste Before (no yank)" })

-- Copy everything between { and } including the brackets
vim.keymap.set("n", "YY", "va{Vy", { desc = "Yank Block {}" })

-- Exit on jj and jk
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit Insert" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit Insert" })

-- Move to start/end of line
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "Start of Line" })
vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "End of Line" })

-- Navigate buffers
vim.keymap.set("n", "<Right>", ":bnext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "<Left>", ":bprevious<CR>", { desc = "Prev Buffer", silent = true })

-- Panes resizing
vim.keymap.set("n", "+", ":vertical resize +5<CR>", { desc = "Increase Width", silent = true })
vim.keymap.set("n", "_", ":vertical resize -5<CR>", { desc = "Decrease Width", silent = true })
vim.keymap.set("n", "=", ":resize +5<CR>", { desc = "Increase Height", silent = true })
vim.keymap.set("n", "-", ":resize -5<CR>", { desc = "Decrease Height", silent = true })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search Partial (centered)" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search Partial Back (centered)" })

-- Split line with X
vim.keymap.set("n", "X", ":keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { desc = "Split Line", silent = true })

-- ctrl + x to cut full line
vim.keymap.set("n", "<C-x>", "dd", { desc = "Cut Line" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })

-- Write file in current directory (:w %:h/<new-file-name>)
vim.keymap.set("n", "<C-n>", ":w %:h/", { desc = "Write New File" })

-- Toggle between Go test and implementation files
vim.keymap.set("n", "<C-P>", ':lua require("config.utils").toggle_go_test()<CR>', { desc = "Toggle Go Test", silent = true })

-- Get highlighted line numbers in visual mode
vim.keymap.set("v", "<leader>ln", ':lua require("config.utils").get_highlighted_line_numbers()<CR>', { desc = "Copy Line Numbers", silent = true })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })
