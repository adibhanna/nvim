-- PHP language server with Intelephense license key
local function get_license()
  local path = os.getenv("HOME") .. "/intelephense/license.txt"
  local f = assert(io.open(path, "rb"))
  local content = f:read("*a")
  f:close()
  return string.gsub(content, "%s+", "")
end

return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php", "blade" },
  root_markers = { "composer.json", ".git" },
  init_options = {
    licenceKey = get_license(),
  },
}
