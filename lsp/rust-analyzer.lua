return {
    filetypes = { "rust" },
    cmd = { "rust-analyzer" },
    root_markers = { '.git', 'Cargo.toml' },
    settings = {
        autoformat = true,
        ["rust-analyzer"] = {
            check = {
                command = "clippy"
            },
        },
    },
}
