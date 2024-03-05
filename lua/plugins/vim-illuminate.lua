return {
  "RRethy/vim-illuminate",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    filetypes_denylist = {
      "mason",
      "harpoon",
      "neo-tree",
      "DressingInput",
      "NeogitCommitMessage",
      "qf",
      "dirvish",
      "fugitive",
      "alpha",
      "NvimTree",
      "lazy",
      "Trouble",
      "netrw",
      "lir",
      "DiffviewFiles",
      "Outline",
      "Jaq",
      "spectre_panel",
      "toggleterm",
      "DressingSelect",
      "TelescopePrompt",
    },
  },
  lazy = false,
  config = function(_, opts)
    require("illuminate").configure(opts)

    local function map(key, dir, buffer)
      vim.keymap.set("n", key, function()
        require("illuminate")["goto_" .. dir .. "_reference"](false)
      end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
    end

    map("]w", "next")
    map("[w", "prev")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buffer = vim.api.nvim_get_current_buf()
        map("]]", "next", buffer)
        map("[[", "prev", buffer)
      end,
    })

    vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      pattern = { "*" },
      callback = function(_)
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
      end,
    })
  end,
  keys = {
    { "]w", desc = "Next Reference" },
    { "[w", desc = "Prev Reference" },
  },
}
