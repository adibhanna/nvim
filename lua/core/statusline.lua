local function lsp_status_short()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end

    return "󰒋 " .. table.concat(names, ",")
end

local function git_branch()
    local ok, handle = pcall(io.popen, "git branch --show-current 2>/dev/null")
    if not ok or not handle then
        return ""
    end
    local branch = handle:read("*a")
    handle:close()
    if branch and branch ~= "" then
        branch = branch:gsub("\n", "")
        return " 󰊢 " .. branch
    end
    return ""
end

local function formatter_status()
    local ok, conform = pcall(require, "conform")
    if not ok then
        return ""
    end

    local formatters = conform.list_formatters_to_run(0)
    if #formatters == 0 then
        return ""
    end

    local formatter_names = {}
    for _, formatter in ipairs(formatters) do
        table.insert(formatter_names, formatter.name)
    end

    return "󰉿 " .. table.concat(formatter_names, ",")
end

local function linter_status()
    local ok, lint = pcall(require, "lint")
    if not ok then
        return ""
    end

    local linters = lint.linters_by_ft[vim.bo.filetype] or {}
    if #linters == 0 then
        return ""
    end

    return "󰁨 " .. table.concat(linters, ",")
end

local function safe_git_branch()
    local ok, result = pcall(git_branch)
    return ok and result or ""
end

local function safe_lsp_status()
    local ok, result = pcall(lsp_status_short)
    return ok and result or ""
end

local function safe_formatter_status()
    local ok, result = pcall(formatter_status)
    return ok and result or ""
end

local function safe_linter_status()
    local ok, result = pcall(linter_status)
    return ok and result or ""
end

local function open_file_explorer()
    require("snacks").explorer.open()
end

local function open_lsp_symbols()
    require("snacks").picker.lsp_symbols()
end

local function open_git_branches()
    require("snacks").picker.git_branches()
end

_G.git_branch = safe_git_branch
_G.lsp_status = safe_lsp_status
_G.formatter_status = safe_formatter_status
_G.linter_status = safe_linter_status
_G.open_file_explorer = open_file_explorer
_G.open_lsp_symbols = open_lsp_symbols
_G.open_git_branches = open_git_branches

-- local function setup_statusline_colors()
--     vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#d4be98" })
--     vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#7c6f64" })
-- end
--
-- setup_statusline_colors()
-- vim.api.nvim_create_autocmd("ColorScheme", {
--     callback = setup_statusline_colors
-- })
--
vim.opt.statusline = " %@v:lua.open_file_explorer@ 󰉋 %X"
    .. "%@v:lua.open_lsp_symbols@ 󰒕 %X"
    .. "%@v:lua.open_git_branches@ 󰊢 %X"
    .. " %f"
    .. "%m"
    .. "%r"
    .. "%="
    .. "%{v:lua.git_branch()}"
    .. " %{v:lua.linter_status()}"
    .. " %{v:lua.formatter_status()}"
    .. " %{v:lua.lsp_status()}"
    .. " %l:%c"
    .. " %p%% "

vim.opt.fillchars:append({ stl = "─", stlnc = "─" })
