-- ============================================================================
-- LSP Server Definitions
-- ============================================================================
-- Each server config is loaded from lsp/<server-name>.lua
-- These configs are automatically managed by Mason (see lua/plugins/mason.lua)

local servers = {
    "lua-ls",        -- Lua language server
    "gopls",         -- Go language server
    "zls",           -- Zig language server
    "ts-ls",         -- TypeScript/JavaScript language server
    "rust-analyzer", -- Rust language server
    "intelephense",  -- PHP language server
    "tailwindcss",   -- Tailwind CSS language server
    "html-ls",       -- HTML language server
    "css-ls",        -- CSS language server
    "vue-ls",        -- Vue language server
}

-- ============================================================================
-- LSP Capabilities Setup (blink.cmp integration)
-- ============================================================================

local function get_capabilities()
    -- Check if blink.cmp is available
    local has_blink, blink = pcall(require, "blink.cmp")

    if has_blink and blink.get_lsp_capabilities then
        -- Merge default capabilities with blink.cmp capabilities
        return vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            blink.get_lsp_capabilities(),
            {
                -- Additional capabilities can be added here
                workspace = {
                    fileOperations = {
                        didRename = true,
                        willRename = true,
                    },
                },
            }
        )
    else
        -- Fallback to default capabilities if blink.cmp is not available
        return vim.lsp.protocol.make_client_capabilities()
    end
end

-- ============================================================================
-- LSP Keymaps (set on attach)
-- ============================================================================

local function setup_keymaps(bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gr", vim.lsp.buf.references, "Go to references")
    map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

    -- Information
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Code actions
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

    -- Diagnostics
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
    map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
    map("n", "<leader>cl", vim.diagnostic.setloclist, "Diagnostics to loclist")

    -- Workspace
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
end

-- ============================================================================
-- LSP Attach Handler
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        -- Setup keymaps for this buffer
        setup_keymaps(bufnr)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Enable inlay hints if supported (Neovim 0.10+)
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Document highlight on cursor hold
        if client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_group,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

-- ============================================================================
-- LSP Server Setup
-- ============================================================================

local capabilities = get_capabilities()

for _, server_name in ipairs(servers) do
    -- Load server-specific config from lsp/<server-name>.lua
    local config_path = vim.fn.stdpath("config") .. "/lsp/" .. server_name .. ".lua"

    if vim.fn.filereadable(config_path) == 1 then
        -- Load the config file
        local ok, server_config = pcall(dofile, config_path)

        if ok and type(server_config) == "table" then
            -- Merge capabilities with server config
            server_config.capabilities = vim.tbl_deep_extend(
                "force",
                capabilities,
                server_config.capabilities or {}
            )

            -- Enable the LSP with the loaded config
            vim.lsp.enable(server_name, server_config)
        else
            -- If config load failed, enable with default config
            vim.notify(
                string.format("Failed to load config for %s, using defaults", server_name),
                vim.log.levels.WARN
            )
            vim.lsp.enable(server_name, { capabilities = capabilities })
        end
    else
        -- No config file, use default config
        vim.lsp.enable(server_name, { capabilities = capabilities })
    end
end

-- ============================================================================
-- Utility Commands
-- ============================================================================

-- LspRestart: Restart LSP clients for current buffer
vim.api.nvim_create_user_command("LspRestart", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        vim.notify("No LSP clients attached to restart", vim.log.levels.WARN)
        return
    end

    for _, client in ipairs(clients) do
        vim.notify("Restarting " .. client.name, vim.log.levels.INFO)
        vim.lsp.stop_client(client.id)
    end

    vim.defer_fn(function()
        vim.cmd("edit")
    end, 100)
end, { desc = "Restart LSP clients for current buffer" })

-- LspStatus: Show brief LSP status
vim.api.nvim_create_user_command("LspStatus", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        print("󰅚 No LSP clients attached")
        return
    end

    print("󰒋 LSP Status for buffer " .. bufnr .. ":")
    print("─────────────────────────────────")

    for i, client in ipairs(clients) do
        print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
        print("  Root: " .. (client.config.root_dir or "N/A"))
        print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

        local caps = client.server_capabilities
        local features = {}
        if caps.completionProvider then table.insert(features, "completion") end
        if caps.hoverProvider then table.insert(features, "hover") end
        if caps.definitionProvider then table.insert(features, "definition") end
        if caps.referencesProvider then table.insert(features, "references") end
        if caps.renameProvider then table.insert(features, "rename") end
        if caps.codeActionProvider then table.insert(features, "code_action") end
        if caps.documentFormattingProvider then table.insert(features, "formatting") end

        print("  Features: " .. table.concat(features, ", "))
        print("")
    end
end, { desc = "Show brief LSP status" })

-- LspCapabilities: Show all capabilities for attached LSP clients
vim.api.nvim_create_user_command("LspCapabilities", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
        print("No LSP clients attached")
        return
    end

    for _, client in ipairs(clients) do
        print("Capabilities for " .. client.name .. ":")
        local caps = client.server_capabilities

        local capability_list = {
            { "Completion",                caps.completionProvider },
            { "Hover",                     caps.hoverProvider },
            { "Signature Help",            caps.signatureHelpProvider },
            { "Go to Definition",          caps.definitionProvider },
            { "Go to Declaration",         caps.declarationProvider },
            { "Go to Implementation",      caps.implementationProvider },
            { "Go to Type Definition",     caps.typeDefinitionProvider },
            { "Find References",           caps.referencesProvider },
            { "Document Highlight",        caps.documentHighlightProvider },
            { "Document Symbol",           caps.documentSymbolProvider },
            { "Workspace Symbol",          caps.workspaceSymbolProvider },
            { "Code Action",               caps.codeActionProvider },
            { "Code Lens",                 caps.codeLensProvider },
            { "Document Formatting",       caps.documentFormattingProvider },
            { "Document Range Formatting", caps.documentRangeFormattingProvider },
            { "Rename",                    caps.renameProvider },
            { "Folding Range",             caps.foldingRangeProvider },
            { "Selection Range",           caps.selectionRangeProvider },
            { "Inlay Hint",                caps.inlayHintProvider },
        }

        for _, cap in ipairs(capability_list) do
            local status = cap[2] and "✓" or "✗"
            print(string.format("  %s %s", status, cap[1]))
        end
        print("")
    end
end, { desc = "Show all LSP capabilities" })

-- LspDiagnostics: Show diagnostic counts
vim.api.nvim_create_user_command("LspDiagnostics", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)

    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diagnostic.severity]
        counts[severity] = counts[severity] + 1
    end

    print("󰒡 Diagnostics for current buffer:")
    print("  Errors: " .. counts.ERROR)
    print("  Warnings: " .. counts.WARN)
    print("  Info: " .. counts.INFO)
    print("  Hints: " .. counts.HINT)
    print("  Total: " .. #diagnostics)
end, { desc = "Show diagnostic counts for current buffer" })

-- LspInfo: Comprehensive LSP information
vim.api.nvim_create_user_command("LspInfo", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    print("═══════════════════════════════════")
    print("           LSP INFORMATION          ")
    print("═══════════════════════════════════")
    print("")

    print("󰈙 Language client log: " .. vim.lsp.get_log_path())
    print("󰈔 Detected filetype: " .. vim.bo.filetype)
    print("󰈮 Buffer: " .. bufnr)
    print("󰈔 Root directory: " .. (vim.fn.getcwd() or "N/A"))
    print("")

    if #clients == 0 then
        print("󰅚 No LSP clients attached to buffer " .. bufnr)
        print("")
        print("Possible reasons:")
        print("  • No language server installed for " .. vim.bo.filetype)
        print("  • Language server not configured")
        print("  • Not in a project root directory")
        print("  • File type not recognized")
        return
    end

    print("󰒋 LSP clients attached to buffer " .. bufnr .. ":")
    print("─────────────────────────────────")

    for i, client in ipairs(clients) do
        print(string.format("󰌘 Client %d: %s", i, client.name))
        print("  ID: " .. client.id)
        print("  Root dir: " .. (client.config.root_dir or "Not set"))
        print("  Command: " .. table.concat(client.config.cmd or {}, " "))
        print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

        if client.is_stopped() then
            print("  Status: 󰅚 Stopped")
        else
            print("  Status: 󰄬 Running")
        end

        if client.workspace_folders and #client.workspace_folders > 0 then
            print("  Workspace folders:")
            for _, folder in ipairs(client.workspace_folders) do
                print("    • " .. folder.name)
            end
        end

        local attached_buffers = {}
        for buf, _ in pairs(client.attached_buffers or {}) do
            table.insert(attached_buffers, buf)
        end
        print("  Attached buffers: " .. #attached_buffers)

        local caps = client.server_capabilities
        local key_features = {}
        if caps.completionProvider then table.insert(key_features, "completion") end
        if caps.hoverProvider then table.insert(key_features, "hover") end
        if caps.definitionProvider then table.insert(key_features, "definition") end
        if caps.documentFormattingProvider then table.insert(key_features, "formatting") end
        if caps.codeActionProvider then table.insert(key_features, "code_action") end

        if #key_features > 0 then
            print("  Key features: " .. table.concat(key_features, ", "))
        end

        print("")
    end

    local diagnostics = vim.diagnostic.get(bufnr)
    if #diagnostics > 0 then
        print("󰒡 Diagnostics Summary:")
        local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

        for _, diagnostic in ipairs(diagnostics) do
            local severity = vim.diagnostic.severity[diagnostic.severity]
            counts[severity] = counts[severity] + 1
        end

        print("  󰅚 Errors: " .. counts.ERROR)
        print("  󰀪 Warnings: " .. counts.WARN)
        print("  󰋽 Info: " .. counts.INFO)
        print("  󰌶 Hints: " .. counts.HINT)
        print("  Total: " .. #diagnostics)
    else
        print("󰄬 No diagnostics")
    end

    print("")
    print("Use :LspLog to view detailed logs")
    print("Use :LspCapabilities for full capability list")
end, { desc = "Show comprehensive LSP information" })
