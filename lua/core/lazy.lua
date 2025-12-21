local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Bootstrap tree-sitter-cli if cargo is available
if vim.fn.executable("tree-sitter") == 0 and vim.fn.executable("cargo") == 1 then
  vim.notify("Installing tree-sitter-cli via cargo...", vim.log.levels.INFO)
  vim.fn.jobstart({ "cargo", "install", "--locked", "tree-sitter-cli" }, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("tree-sitter-cli installed successfully!", vim.log.levels.INFO)
      else
        vim.notify("Failed to install tree-sitter-cli", vim.log.levels.WARN)
      end
    end,
  })
end

require("lazy").setup({ import = "plugins" }, {
  install = {
    missing = true,
    colorscheme = { "habamax" }
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    -- border = "rounded"
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
