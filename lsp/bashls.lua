-- Bash/Shell language server
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
  root_markers = { ".git" },
}
