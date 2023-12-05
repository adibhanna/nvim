return {
  "j-hui/fidget.nvim",
  branch = "legacy",
  enabled = false,
  config = function()
    require('fidget').setup({
      window = { blend = 0 },
    })
  end
}
