return {
  {
    "pmizio/typescript-tools.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          expose_as_code_action = "all",
          -- tsserver_plugins = {},
          tsserver_max_memory = "auto",
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all", -- "none" | "literals" | "all";
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
            -- autoImportFileExcludePatterns = { "node_modules/*", ".git/*" },
          },
        },
      })
    end,
  },
  {
    "vuki656/package-info.nvim",
    event = "BufReadPre",
    config = function()
      require("package-info").setup()
    end,
    keys = {
      -- Show dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })
      --
      -- -- Hide dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })
      --
      -- -- Toggle dependency versions
      -- vim.keymap.set({ "n" }, "<LEADER>nt", require("package-info").toggle, { silent = true, noremap = true })
      --
      -- -- Update dependency on the line
      -- vim.keymap.set({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })
      --
      -- -- Delete dependency on the line
      -- vim.keymap.set({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })
      --
      -- -- Install a new dependency
      -- vim.keymap.set({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })
      --
      -- -- Install a different dependency version
      -- vim.keymap.set({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })

      { "<leader>Ns", "<cmd>lua require('package-info').show()<CR>", desc = "Show dependency versions" },
      { "<leader>Nc", "<cmd>lua require('package-info').hide()<CR>", desc = "Hide dependency versions" },
      { "<leader>NT", "<cmd>lua require('package-info').toggle()<CR>", desc = "Toggle dependency versions" },
      { "<leader>Nu", "<cmd>lua require('package-info').update()<CR>", desc = "Update dependency on the line" },
      { "<leader>Nd", "<cmd>lua require('package-info').delete()<CR>", desc = "Delete dependency on the line" },
      { "<leader>Ni", "<cmd>lua require('package-info').install()<CR>", desc = "Install a new dependency" },
      {
        "<leader>Np",
        "<cmd>lua require('package-info').change_version()<CR>",
        desc = "Install a different dependency version",
      },
      { "<leader>Nt", ":Telescope package_info<CR>", desc = "Telescope package info" },
    },
  },
}
