-- Zig language server
return {
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_markers = { "build.zig", ".git" },
}
