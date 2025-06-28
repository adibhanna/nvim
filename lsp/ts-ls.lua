local blink = require("blink.cmp")

-- based on https://dev.to/danwalsh/solved-vue-3-typescript-inlay-hint-support-in-neovim-53ej
return {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        -- "vue"
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    -- Temporarily removing init_options to see if Vue plugin is causing issues
    -- init_options = {
    --     plugins = {
    --         {
    --             name = '@vue/typescript-plugin',
    --             location = vim.fn.stdpath('data') ..
    --                 '/mason/packages/vue-language-server/node_modules/@vue/language-server',
    --             languages = { 'vue' },
    --         },
    --     },
    -- },
    settings = {
        typescript = {
            -- Remove tsdk setting to allow auto-detection
            tsserver = {
                useSyntaxServer = false,
            },
            inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            -- Remove tsdk setting to allow auto-detection
        },
    },
    handlers = {
        ["textDocument/hover"] = function(_, result, ctx, config)
            -- Suppress "No information available" when TypeScript returns empty docs
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
