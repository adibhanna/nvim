return {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtual_text = require("nvim-dap-virtual-text")

        dap.adapters.lldb = {
            type = 'executable',
            command = '/opt/homebrew/opt/llvm/bin/lldb-vscode', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        dapui.setup()
        virtual_text.setup()
    end
}
