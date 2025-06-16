-- Mason verification utility
local M = {}

-- Check if a tool is managed by Mason
function M.is_mason_tool(tool_name)
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/" .. tool_name
    return vim.fn.executable(mason_bin) == 1
end

-- Get the path of a tool
function M.get_tool_path(tool_name)
    return vim.fn.exepath(tool_name)
end

-- Check all tools and report which are Mason-managed
function M.verify_tools()
    -- Debug: Show current PATH
    print("Current Neovim PATH (first 3 entries):")
    local path_entries = vim.split(vim.env.PATH, ":")
    for i = 1, math.min(3, #path_entries) do
        local marker = (string.find(path_entries[i], "mason") and "🔧" or "  ")
        print(string.format("%s %d: %s", marker, i, path_entries[i]))
    end
    print("")
    local mason_tools = {
        -- LSP Servers (Mason-managed)
        "gopls", "lua-language-server", "rust-analyzer",
        "typescript-language-server", "intelephense", "zls",

        -- Formatters (Mason-managed)
        "stylua", "prettier", "goimports", "black", "isort", "shfmt", "pint",

        -- Linters (Mason-managed)
        "golangci-lint", "eslint_d", "luacheck", "shellcheck"
    }

    local system_tools = {
        -- System tools (not managed by Mason)
        "gofmt",   -- Comes with Go installation
        "rustfmt", -- Comes with Rust installation
    }

    print("═══════════════════════════════════")
    print("         MASON TOOL VERIFICATION    ")
    print("═══════════════════════════════════")

    print("\n📦 MASON-MANAGED TOOLS:")
    local mason_found = 0
    local mason_total = 0

    for _, tool in ipairs(mason_tools) do
        mason_total = mason_total + 1
        if vim.fn.executable(tool) == 1 then
            local path = M.get_tool_path(tool)
            local is_mason = string.find(path, "mason", 1, true) ~= nil
            local status = is_mason and "✅ MASON" or "❌ SYSTEM"

            if is_mason then
                mason_found = mason_found + 1
            end

            print(string.format("%-25s %s", tool, status))
            if not is_mason then
                print(string.format("  └─ %s", path))
            end
        else
            print(string.format("%-25s ❌ NOT FOUND", tool))
        end
    end

    print("\n🔧 SYSTEM TOOLS (Not managed by Mason):")
    for _, tool in ipairs(system_tools) do
        if vim.fn.executable(tool) == 1 then
            local path = M.get_tool_path(tool)
            print(string.format("%-25s ✅ SYSTEM", tool))
        else
            print(string.format("%-25s ❌ NOT FOUND", tool))
        end
    end

    print("\n═══════════════════════════════════")
    print(string.format("Mason-managed: %d/%d tools", mason_found, mason_total))

    if mason_found == mason_total then
        print("🎉 All Mason tools are properly managed!")
    else
        print("⚠️  Some Mason tools are using system versions")
        print("💡 Try restarting Neovim or run :MasonUpdate")
    end
end

-- Function to fix PATH manually
function M.fix_path()
    local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
    local current_path = vim.env.PATH or ""

    -- Remove any existing Mason bin entries to prevent duplicates
    local path_entries = vim.split(current_path, ":")
    local clean_path_entries = {}
    local mason_found = false

    for _, entry in ipairs(path_entries) do
        if entry == mason_bin then
            mason_found = true
        else
            table.insert(clean_path_entries, entry)
        end
    end

    -- Add Mason bin directory at the beginning
    local new_path = mason_bin .. ":" .. table.concat(clean_path_entries, ":")
    vim.env.PATH = new_path

    if mason_found then
        print("🔄 Cleaned duplicate Mason entries from PATH")
    else
        print("✅ Added Mason bin to PATH: " .. mason_bin)
    end

    -- Note: Neovim will automatically refresh executable paths
    print("🔄 PATH updated - executable paths will refresh automatically")
end

-- Create commands
vim.api.nvim_create_user_command('MasonVerify', M.verify_tools, { desc = "Verify Mason tool management" })
vim.api.nvim_create_user_command('MasonFixPath', M.fix_path, { desc = "Fix Mason PATH manually" })

return M
