-- Comprehensive health check for the entire Neovim configuration
local M = {}

function M.check_all()
    print("═══════════════════════════════════")
    print("      NEOVIM CONFIGURATION HEALTH   ")
    print("═══════════════════════════════════")
    print("")

    -- Check Mason tools
    print("🔧 MASON TOOLS:")
    local mason_verify = require("config.mason-verify")
    mason_verify.verify_tools()
    print("")

    -- Check LSP status
    print("󰒋 LSP STATUS:")
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients > 0 then
        for _, client in ipairs(clients) do
            print("  ✓ " .. client.name .. " (ID: " .. client.id .. ")")
        end
    else
        print("  ⚠ No LSP clients attached to current buffer")
    end
    print("")

    -- Check formatters
    print("󰉿 FORMATTERS:")
    local ok, conform = pcall(require, "conform")
    if ok then
        local formatters = conform.list_formatters_to_run(0)
        if #formatters > 0 then
            for _, formatter in ipairs(formatters) do
                print("  ✓ " .. formatter.name)
            end
        else
            print("  ⚠ No formatters available for " .. vim.bo.filetype)
        end
    else
        print("  ✗ Conform.nvim not loaded")
    end
    print("")

    -- Check linters
    print("󰁨 LINTERS:")
    local ok, lint = pcall(require, "lint")
    if ok then
        local linters = lint.linters_by_ft[vim.bo.filetype] or {}
        if #linters > 0 then
            for _, linter in ipairs(linters) do
                print("  ✓ " .. linter)
            end
        else
            print("  ⚠ No linters configured for " .. vim.bo.filetype)
        end
    else
        print("  ✗ nvim-lint not loaded")
    end
    print("")

    -- Check key plugins
    print("📦 KEY PLUGINS:")
    local plugins_to_check = {
        { name = "mason",      module = "mason" },
        { name = "conform",    module = "conform" },
        { name = "lint",       module = "lint" },
        { name = "trouble",    module = "trouble" },
        { name = "dap",        module = "dap" },
        { name = "treesitter", module = "nvim-treesitter" },
    }

    for _, plugin in ipairs(plugins_to_check) do
        local ok, _ = pcall(require, plugin.module)
        if ok then
            print("  ✓ " .. plugin.name)
        else
            print("  ✗ " .. plugin.name .. " (not loaded)")
        end
    end
    print("")

    print("Run :checkhealth for detailed Neovim health information")
    print("Run :MasonVerify for detailed Mason tool verification")
end

-- Create user command
vim.api.nvim_create_user_command('HealthCheck', M.check_all, { desc = "Run comprehensive configuration health check" })

return M
