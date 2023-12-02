local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        -- component_separators = '│',
        -- section_separators = '',
        disabled_filetypes = {
          statusline = {
            'help',
            -- 'startify',
            -- 'dashboard',
            'neo-tree',
            -- 'packer',
            -- 'neogitstatus',
            -- 'NvimTree',
            'Trouble',
            'alpha',
            -- 'lir',
            'Outline',
            'spectre_panel',
            'toggleterm',
            -- 'qf',
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = "  ",
              readonly = "",
              unnamed = ""
            }
          },
          { "aerial" },
          { "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          -- { "searchcount" },
        },
        lualine_x = { { 'diff', source = diff_source }, { 'b:gitsigns_head', icon = '' }, "progress" },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
