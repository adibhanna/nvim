-- Early Mason PATH initialization
-- This ensures Mason's bin directory is always first in PATH
--
-- PURPOSE & PROBLEM IT SOLVES:
-- When you install tools via Mason (like golangci-lint, stylua, prettier, etc.),
-- they get installed to ~/.local/share/nvim/mason/bin/. However, if you also have
-- system versions of these tools installed (via brew, apt, etc.), your shell's
-- PATH might find the system version first, leading to:
--
-- - Version conflicts - Using an older system version instead of the Mason version
-- - Configuration issues - Mason tools might be configured differently
-- - Inconsistent behavior - Different versions behaving differently
--
-- THE SOLUTION:
-- This file prepends Mason's bin directory to the PATH environment variable,
-- ensuring Mason tools are found first:
-- Before: PATH = "/usr/local/bin:/usr/bin:/bin"
-- After:  PATH = "/Users/you/.local/share/nvim/mason/bin:/usr/local/bin:/usr/bin:/bin"
--
-- KEY FEATURES:
-- 1. Deduplication: Removes any existing Mason bin entries to prevent duplicates in PATH
-- 2. Early initialization: Runs before other plugins load, ensuring Mason tools are available immediately
-- 3. Directory creation: Creates the Mason bin directory if it doesn't exist yet
-- 4. Clean PATH management: Maintains a clean PATH without multiple Mason entries
--
-- WHY IT'S IMPORTANT:
-- In this configuration, Mason manages 16+ tools:
-- - LSP servers: gopls, lua-language-server, etc.
-- - Formatters: stylua, prettier, goimports, etc.
-- - Linters: golangci-lint, eslint_d, luacheck, etc.
--
-- Without this file, you might end up using system versions instead of Mason versions,
-- which could cause:
-- - The :MasonVerify command showing tools as "not Mason-managed"
-- - Inconsistent formatting/linting behavior
-- - Version-specific bugs or missing features
--
-- INTEGRATION WITH WORKFLOW:
-- This file works together with:
-- - lua/config/mason-verify.lua - Verifies which tools are Mason-managed
-- - lua/plugins/mason.lua - Installs and manages the tools
-- - Your linter/formatter configs - Use the Mason versions consistently
--
-- It's essentially the "foundation" that makes your entire Mason-based toolchain
-- work reliably by ensuring the right tools are found in the right order.

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local current_path = vim.env.PATH or ""

-- Remove any existing Mason bin entries to prevent duplicates
local path_entries = vim.split(current_path, ":")
local clean_path_entries = {}
local seen = {}

for _, entry in ipairs(path_entries) do
    -- Skip Mason bin entries and duplicates
    if entry ~= mason_bin and entry ~= "" and not seen[entry] then
        seen[entry] = true
        table.insert(clean_path_entries, entry)
    end
end

-- Add Mason bin directory at the beginning
local new_path = mason_bin .. ":" .. table.concat(clean_path_entries, ":")
vim.env.PATH = new_path

-- Verify Mason bin directory exists
if vim.fn.isdirectory(mason_bin) == 0 then
    -- Mason not installed yet, create placeholder
    vim.fn.mkdir(mason_bin, "p")
end
