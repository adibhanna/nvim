return {
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
    config = function(_, _)
      require("ts_context_commentstring").setup({})
      require("mini.comment").setup()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
}
