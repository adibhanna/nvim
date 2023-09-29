return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  lazy = true,
  config = function()
    require("trouble").setup {
      -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      mode = "workspace_diagnostics",
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 15,
      padding = false,
      action_keys = {
        -- key mappings for actions in the trouble list
        close = "q",                -- close the list
        cancel = "<esc>",           -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r",              -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" },   -- open buffer in new split
        open_vsplit = { "<c-v>" },  -- open buffer in new vsplit
        open_tab = { "<c-t>" },     -- open buffer in new tab
        jump_close = { "o" },       -- jump to the diagnostic and close the list
        toggle_mode = "m",          -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P",       -- toggle auto_preview
        hover = "K",                -- opens a small popup with the full multiline message
        preview = "p",              -- preview the diagnostic location
        close_folds = { "zM" },     -- close all folds
        open_folds = { "zR" },      -- open all folds
        toggle_fold = { "za" },     -- toggle fold of current file
      },
      auto_jump = {},
      use_diagnostic_signs = true,
    }
  end
}
