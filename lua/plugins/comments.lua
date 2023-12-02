return {
  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {},
    config = function(_, _)
      require("mini.comment").setup()
      require("ts_context_commentstring").setup()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
}
