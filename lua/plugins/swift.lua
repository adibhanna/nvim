-- Swift/iOS development support
return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-tree.lua",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("xcodebuild").setup({
        show_build_progress_bar = true,
        logs = {
          auto_open_on_success_tests = false,
          auto_open_on_failed_tests = false,
          auto_open_on_success_build = false,
          auto_open_on_failed_build = true,
          auto_focus = false,
        },
        code_coverage = {
          enabled = true,
        },
      })

      -- Keymaps for xcodebuild (under <leader>x)
      local map = function(keys, cmd, desc)
        vim.keymap.set("n", keys, cmd, { desc = desc, silent = true })
      end

      -- Build & Run
      map("<leader>xb", "<cmd>XcodebuildBuild<cr>", "Build")
      map("<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", "Build for Testing")
      map("<leader>xr", "<cmd>XcodebuildBuildRun<cr>", "Build & Run")
      map("<leader>xR", "<cmd>XcodebuildRun<cr>", "Run (no build)")

      -- Tests
      map("<leader>xt", "<cmd>XcodebuildTest<cr>", "Run Tests")
      map("<leader>xT", "<cmd>XcodebuildTestClass<cr>", "Test Current Class")
      map("<leader>xf", "<cmd>XcodebuildTestFunc<cr>", "Test Current Function")
      map("<leader>xF", "<cmd>XcodebuildTestSelected<cr>", "Test Selected")
      map("<leader>xn", "<cmd>XcodebuildTestNearest<cr>", "Test Nearest")
      map("<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", "Select Test Plan")

      -- Project
      map("<leader>xs", "<cmd>XcodebuildSetup<cr>", "Setup Project")
      map("<leader>xS", "<cmd>XcodebuildSelectScheme<cr>", "Select Scheme")
      map("<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", "Select Device")
      map("<leader>xP", "<cmd>XcodebuildPicker<cr>", "Xcode Picker")

      -- Utilities
      map("<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", "Toggle Logs")
      map("<leader>xc", "<cmd>XcodebuildClean<cr>", "Clean")
      map("<leader>xC", "<cmd>XcodebuildCleanBuild<cr>", "Clean Build")
      map("<leader>xq", "<cmd>XcodebuildQuickfixLine<cr>", "Quickfix Line")
      map("<leader>xa", "<cmd>XcodebuildCodeActions<cr>", "Code Actions")

      -- Simulator
      map("<leader>xo", "<cmd>XcodebuildBootSimulator<cr>", "Boot Simulator")
      map("<leader>xi", "<cmd>XcodebuildInstallApp<cr>", "Install App")
      map("<leader>xu", "<cmd>XcodebuildUninstallApp<cr>", "Uninstall App")
    end,
    ft = { "swift" },
    cmd = {
      "XcodebuildSetup",
      "XcodebuildPicker",
      "XcodebuildBuild",
      "XcodebuildBuildRun",
      "XcodebuildRun",
      "XcodebuildTest",
      "XcodebuildSelectScheme",
      "XcodebuildSelectDevice",
      "XcodebuildSelectTestPlan",
    },
  },
}
