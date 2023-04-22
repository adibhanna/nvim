return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function ()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        auto_install = true,
        ensure_installed = {
          "bash",
          "c",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "rust",
          "go"
        },
      }
    end
  },
}
