local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n",   -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
     R = {
        name = "+Rust",
        j = { "<cmd>lua require('rust-tools').join_lines.join_lines()<CR>", "Join Lines" },
        r = { "<cmd>RustRunnables<Cr>", "Runnables" },
        t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
        m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
        c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
        p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
        d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
        v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
        R = {
            "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
            "Reload Workspace",
        },
    },
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
    }
}

which_key.register(mappings, opts)
