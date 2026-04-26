-- SourceKit-LSP for Swift (not managed by Mason)
return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
  root_markers = { "Package.swift", ".git", "compile_commands.json" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
}
