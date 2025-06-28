local blink = require("blink.cmp")

-- Function to get TypeScript SDK path (prefer local, fallback to global)
local function get_typescript_sdk()
    local local_sdk = vim.fn.getcwd() .. '/node_modules/typescript/lib'
    if vim.fn.isdirectory(local_sdk) == 1 then
        return local_sdk
    end

    -- Try global installation
    local global_root = vim.fn.system('npm root -g'):gsub('\n', ''):gsub('\r', '')
    local global_sdk = global_root .. '/typescript/lib'
    if vim.fn.isdirectory(global_sdk) == 1 then
        return global_sdk
    end

    -- If both fail, return nil to let vue-language-server find it automatically
    return nil
end

return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    init_options = {
        vue = {
            hybridMode = false, -- Disable for inlay hints support
        },
        -- Only set typescript config if we have a valid TypeScript installation
        typescript = get_typescript_sdk() and {
            tsdk = get_typescript_sdk(),
        } or nil,
    },
    settings = {
        -- Remove TypeScript-specific settings to avoid conflicts with ts-ls
        -- Let the TypeScript Language Server handle TypeScript features
    },
    handlers = {
        ["textDocument/hover"] = function(_, result, ctx, config)
            -- Suppress "No information available" when Vue returns empty docs
            if not (result and result.contents) or result.contents == '' or (type(result.contents) == 'table' and vim.tbl_isempty(result.contents)) then
                return
            end
            vim.lsp.handlers.hover(_, result, ctx, config)
        end,
    },
    capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        blink.get_lsp_capabilities()
    ),
}
