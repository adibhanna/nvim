return {
  "j-hui/fidget.nvim",
  branch = "legacy",
  config = function()
    require('fidget').setup({
      window = { blend = 0 },
    })
  end
}
