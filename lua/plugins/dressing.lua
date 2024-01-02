return {
  'stevearc/dressing.nvim',
  depends = { 'MunifTanjim/nui.nvim' },
  opts = {},
  config = function()
    require('dressing').setup()
  end
}
