local blink = require("blink.cmp")

return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "html",
        "blade",
        "css",
        "scss",
        "rust",
        "php",
        "go",
    },
    root_markers = {
        "tailwind.config.js",
        "tailwind.config.cjs",
        "tailwind.config.mjs",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        "package.json",
        ".git",
    },
    settings = {
        tailwindCSS = {
            emmetCompletions = true,
            validate = true,
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidScreen = "error",
                invalidVariant = "error",
                invalidConfigPath = "error",
                invalidTailwindDirective = "error",
                recommendedVariantOrder = "warning",
            },
            -- Tailwind class attributes configuration
            classAttributes = { "class", "className", "classList", "ngClass", ":class" },

            -- Experimental regex patterns to detect Tailwind classes in various syntaxes
            experimental = {
                classRegex = {
                    -- tw`...` or tw("...")
                    "tw`([^`]*)`",
                    "tw\\(([^)]*)\\)",

                    -- @apply directive inside SCSS / CSS
                    "@apply\\s+([^;]*)",

                    -- class and className attributes (HTML, JSX, Vue, Blade with :class)
                    'class="([^"]*)"',
                    'className="([^"]*)"',
                    ':class="([^"]*)"',

                    -- Laravel @class directive e.g. @class([ ... ])
                    "@class\\(([^)]*)\\)",
                },
            },
        },
    },
    handlers = {
        ["textDocument/hover"] = function(_, result, ctx, config)
            -- Suppress "No information available" when Tailwind returns empty docs
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
