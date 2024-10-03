return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "telescope-dap.nvim",
      "kkharji/sqlite.lua",
      -- "nvim-telescope/telescope-frecency.nvim",
    },
    keys = {
      -- f = { require("config.utils").telescope_git_or_file, "Find Files (Root)" },
      -- map("<leader>o", require("telescope.builtin").buffers, "Buffers")
      -- {
      --   "<leader>gt", ":Telescope golang_test_files<cr>", desc = "Search golang Tests",
      -- },

      {
        "<leader>f", function() require("config.utils").telescope_git_or_file() end, desc = "Find Files (Root)",
      },
      {
        "<leader>o", function() require("telescope.builtin").buffers() end, desc = "Buffers",
      },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find File (CWD)",
      },
      {
        "<leader>sg",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Search Git Files",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Find Help",
      },
      {
        "<leader>sH",
        function()
          require("telescope.builtin").highlights()
        end,
        desc = "Find highlight groups",
      },
      {
        "<leader>sM",
        function()
          require("telescope.builtin").man_pages()
        end,
        desc = "Map Pages",
      },
      {
        "<leader>so",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Open Recent File",
      },
      {
        "<leader>sR",
        function()
          require("telescope.builtin").registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>st",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>sT",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Grep String",
      },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sC",
        function()
          require("telescope.builtin").commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sl",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last search",
      },
      {
        "<leader>sc",
        function()
          require("telescope.builtin").git_commits()
        end,
        desc = "Git commits",
      },
      {
        "<leader>sB",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>sm",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "Git status",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").git_stash()
        end,
        desc = "Git stash",
      },
      -- {
      --   "<leader>se",
      --   function()
      --     require("telescope.builtin").frecency()
      --   end,
      --   desc = "Frecency",
      -- },
      {
        "<leader>sb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")
      local icons = require("config.icons")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      -- local function formattedName(_, path)
      --   local tail = vim.fs.basename(path)
      --   local parent = vim.fs.dirname(path)
      --   if parent == "." then
      --     return tail
      --   end
      --   return string.format("%s\t\t%s", tail, parent)
      -- end

      local function document_symbols_for_selected(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")
        local entry = action_state.get_selected_entry()

        if entry == nil then
          print("No file selected")
          return
        end

        actions.close(prompt_bufnr)

        vim.schedule(function()
          local bufnr = vim.fn.bufadd(entry.path)
          vim.fn.bufload(bufnr)

          local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

          vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
            if err then
              print("Error getting document symbols: " .. vim.inspect(err))
              return
            end

            if not result or vim.tbl_isempty(result) then
              print("No symbols found")
              return
            end

            local function flatten_symbols(symbols, parent_name)
              local flattened = {}
              for _, symbol in ipairs(symbols) do
                local name = symbol.name
                if parent_name then
                  name = parent_name .. "." .. name
                end
                table.insert(flattened, {
                  name = name,
                  kind = symbol.kind,
                  range = symbol.range,
                  selectionRange = symbol.selectionRange,
                })
                if symbol.children then
                  local children = flatten_symbols(symbol.children, name)
                  for _, child in ipairs(children) do
                    table.insert(flattened, child)
                  end
                end
              end
              return flattened
            end

            local flat_symbols = flatten_symbols(result)

            -- Define highlight group for symbol kind
            vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

            require("telescope.pickers").new({}, {
              prompt_title = "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"),
              finder = require("telescope.finders").new_table({
                results = flat_symbols,
                entry_maker = function(symbol)
                  local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
                  return {
                    value = symbol,
                    display = function(entry)
                      local display_text = string.format("%-50s %s", entry.value.name, kind)
                      return display_text, { { { #entry.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
                    end,
                    ordinal = symbol.name,
                    filename = entry.path,
                    lnum = symbol.selectionRange.start.line + 1,
                    col = symbol.selectionRange.start.character + 1,
                  }
                end,
              }),
              sorter = require("telescope.config").values.generic_sorter({}),
              previewer = require("telescope.config").values.qflist_previewer({}),
              attach_mappings = function(_, map)
                map("i", "<CR>", function(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  actions.close(prompt_bufnr)
                  vim.cmd("edit " .. selection.filename)
                  vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
                end)
                return true
              end,
            }):find()
          end)
        end)
      end

      telescope.setup({
        file_ignore_patterns = { "%.git/." },
        -- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-t>"] = trouble.open,

              ["<C-s>"] = document_symbols_for_selected,
            },

            n = {
              ["<C-t>"] = trouble.open,
              ["<C-s>"] = document_symbols_for_selected,
            },


          },
          -- path_display = formattedName,
          path_display = {
            "filename_first",
          },
          previewer = false,
          prompt_prefix = " " .. icons.ui.Telescope .. " ",
          selection_caret = icons.ui.BoldArrowRight .. " ",
          file_ignore_patterns = { "node_modules", "package-lock.json" },
          initial_mode = "insert",
          select_strategy = "reset",
          sorting_strategy = "ascending",
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
        },
        pickers = {
          find_files = {
            previewer = false,
            -- path_display = formattedName,
            layout_config = {
              height = 0.4,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          git_files = {
            previewer = false,
            -- path_display = formattedName,
            layout_config = {
              height = 0.4,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          buffers = {
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
            previewer = false,
            initial_mode = "normal",
            -- theme = "dropdown",
            layout_config = {
              height = 0.4,
              width = 0.6,
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          current_buffer_fuzzy_find = {
            previewer = true,
            layout_config = {
              prompt_position = "top",
              preview_cutoff = 120,
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
          },
          grep_string = {
            only_sort_text = true,
            previewer = true,
          },
          lsp_references = {
            show_line = false,
            previewer = true,
          },
          treesitter = {
            show_line = false,
            previewer = true,
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer = false,
              initial_mode = "normal",
              sorting_strategy = "ascending",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            }),
          },
          package_info = {
            -- Optional theme (the extension doesn't set a default theme)
            -- theme = "ivy",
          },
          -- frecency = {
          --   default_workspace = "CWD",
          --   show_scores = true,
          --   show_unindexed = true,
          --   disable_devicons = false,
          --   ignore_patterns = {
          --     "*.git/*",
          --     "*/tmp/*",
          --     "*/lua-language-server/*",
          --   },
          -- },
        },
        -- golang_test_files = require('config.telescope.golang_test_files'),
      })
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      -- telescope.load_extension("refactoring")
      telescope.load_extension("dap")
      -- telescope.load_extension("frecency")
      telescope.load_extension("notify")
      telescope.load_extension("package_info")
      -- telescope.load_extension('golang_test_files')
      telescope.load_extension("makefile_targets")
    end,
  },
}
