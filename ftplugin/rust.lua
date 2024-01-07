local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    C = {
        name = "+Rust Crates",
        o = { "<cmd>lua require('crates').show_popup()<CR>", "Show popup" },
        r = { "<cmd>lua require('crates').reload()<CR>", "Reload" },
        v = { "<cmd>lua require('crates').show_versions_popup()<CR>", "Show Versions" },
        f = { "<cmd>lua require('crates').show_features_popup()<CR>", "Show Features" },
        d = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", "Show Dependencies Popup" },
        u = { "<cmd>lua require('crates').update_crate()<CR>", "Update Crate" },
        a = { "<cmd>lua require('crates').update_all_crates()<CR>", "Update All Crates" },
        U = { "<cmd>lua require('crates').upgrade_crate<CR>", "Upgrade Crate" },
        A = { "<cmd>lua require('crates').upgrade_all_crates(true)<CR>", "Upgrade All Crates" },
        H = { "<cmd>lua require('crates').open_homepage()<CR>", "Open Homepage" },
        R = { "<cmd>lua require('crates').open_repository()<CR>", "Open Repository" },
        D = { "<cmd>lua require('crates').open_documentation()<CR>", "Open Documentation" },
        C = { "<cmd>lua require('crates').open_crates_io()<CR>", "Open Crate.io" },
    },
    l = {
        name = "+LSP",
        a = { "<cmd>lua vim.cmd.RustLsp('codeAction')<cr>", "Rust Code Action" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
        o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
        R = { "<cmd>Telescope lsp_references<cr>", "References" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display Signature Information" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all references" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        k = { "<cmd>lua vim.cmd.RustLsp { 'hover', 'actions' }<cr>", "Hover" },
        l = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
        L = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        c = { "<cmd>lua require('config.utils').copyFilePathAndLineNumber()<CR>", "Copy File Path and Line Number" },
    },
}

which_key.register(mappings, opts)

vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", { silent = true, desc = "Rust Hover" })
vim.keymap.set("n", "gl", "<cmd>RustLsp explainError<CR>", { silent = true, desc = "Explain error" })
