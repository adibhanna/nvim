-- ============================================================================
-- Leader Keys
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Disable Built-in Plugins
-- ============================================================================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================================================
-- Disable Providers (silence health check warnings)
-- ============================================================================
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- ============================================================================
-- Editor Behavior
-- ============================================================================
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.updatetime = 100
vim.opt.timeoutlen = 1000
vim.opt.confirm = true
vim.opt.autoread = true

-- ============================================================================
-- UI/Display
-- ============================================================================
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.ruler = true
vim.opt.showtabline = 0
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.fillchars = { eob = " " }
vim.o.winborder = "rounded"

-- ============================================================================
-- Search
-- ============================================================================
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ============================================================================
-- Indentation
-- ============================================================================
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- ============================================================================
-- Splits
-- ============================================================================
vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- Files
-- ============================================================================
vim.opt.fileencoding = "utf-8"
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- ============================================================================
-- Completion
-- ============================================================================
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0

-- ============================================================================
-- Other
-- ============================================================================
vim.opt.title = true
vim.opt.guifont = "monospace:h17"

-- ============================================================================
-- Filetype Detection
-- ============================================================================
vim.filetype.add({
    extension = {
        env = "dotenv",
    },
    filename = {
        [".env"] = "dotenv",
        ["env"] = "dotenv",
    },
    pattern = {
        ["[jt]sconfig.*.json"] = "jsonc",
        ["%.env%.[%w_.-]+"] = "dotenv",
    },
})
