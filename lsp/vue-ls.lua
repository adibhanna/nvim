local blink = require("blink.cmp")

return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    init_options = {
        vue = {
            hybridMode = false, -- Disable for inlay hints support
        },
        typescript = {
            -- Let ts-ls handle TypeScript features
            tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
        },
    },
    settings = {
        typescript = {
            inlayHints = {
                enumMemberValues = {
                    enabled = true,
                },
                functionLikeReturnTypes = {
                    enabled = true,
                },
                propertyDeclarationTypes = {
                    enabled = true,
                },
                parameterTypes = {
                    enabled = true,
                    suppressWhenArgumentMatchesName = true,
                },
                variableTypes = {
                    enabled = true,
                },
            },
        },
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
