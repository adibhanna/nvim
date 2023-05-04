return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = false,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },       -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },       -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },           -- Required
      { 'hrsh7th/cmp-nvim-lsp' },       -- Required
      { 'L3MON4D3/LuaSnip' },           -- Required

      { 'onsails/lspkind.nvim' },
    },
    config = function()
      local lsp = require('lsp-zero').preset("recommended")

      lsp.ensure_installed({
        'tsserver',
        -- 'eslint',
        'rust_analyzer',
        'gopls',
        -- 'bashls',
      })

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      -- require('lspconfig').eslint.setup({
      --   filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
      --   settings = {
      --     format = { enable = true },
      --     lint = { enable = true },
      --   },
      -- })

      lsp.skip_server_setup({ 'rust_analyzer', 'gopls' })
      lsp.setup()

      -- cmp icons
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local icons = require('config.icons')
      local luasnip = require('luasnip')
      local cmp_mapping = require('cmp.config.mapping')
      local cmp_types = require('cmp.types.cmp')
      local utils = require('plugins.utils')
      cmp.setup {
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local max_width = 0
            if max_width ~= 0 and #vim_item.abbr > max_width then
              vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. icons.ui.Ellipsis
            end
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind

            if entry.source.name == "copilot" then
              vim_item.kind = icons.git.Octoface
              vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            if entry.source.name == "crates" then
              vim_item.kind = icons.misc.Package
              vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "emoji" then
              vim_item.kind = icons.misc.Smiley
              vim_item.kind_hl_group = "CmpItemKindEmoji"
            end
            vim_item.menu = ({
              nvim_lsp = "(LSP)",
              emoji = "(Emoji)",
              path = "(Path)",
              calc = "(Calc)",
              vsnip = "(Snippet)",
              luasnip = "(Snippet)",
              buffer = "(Buffer)",
              tmux = "(TMUX)",
              copilot = "(Copilot)",
              treesitter = "(TreeSitter)",
            })[entry.source.name]
            vim_item.dup = ({
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 1,
            })[entry.source.name] or 0
            return vim_item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = require('cmp.config.window').bordered(),
          documentation = require('cmp.config.window').bordered(),
        },
        sources = {
          {
            name = "copilot",
            -- keyword_length = 0,
            max_item_count = 3,
            trigger_characters = {
              {
                ".",
                ":",
                "(",
                "'",
                '"',
                "[",
                ",",
                "#",
                "*",
                "@",
                "|",
                "=",
                "-",
                "{",
                "/",
                "\\",
                "+",
                "?",
                " ",
                -- "\t",
                -- "\n",
              },
            },
          },
          {
            name = "nvim_lsp",
            entry_filter = function(entry, ctx)
              local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
              if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                return false
              end
              if kind == "Text" then
                return false
              end
              return true
            end,
          },

          { name = "path" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "buffer" },
          { name = "calc" },
          { name = "emoji" },
          { name = "treesitter" },
          { name = "crates" },
          { name = "tmux" },
        },
        mapping = cmp_mapping.preset.insert {
          ["<C-k>"] = cmp_mapping(cmp_mapping.select_prev_item(), { "i", "c" }),
          ["<C-j>"] = cmp_mapping(cmp_mapping.select_next_item(), { "i", "c" }),
          ["<Down>"] = cmp_mapping(cmp_mapping.select_next_item { behavior = cmp_types.SelectBehavior.Select }, {
            "i" }),
          ["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item { behavior = cmp_types.SelectBehavior.Select }, {
            "i" }),
          ["<C-d>"] = cmp_mapping.scroll_docs(-4),
          ["<C-f>"] = cmp_mapping.scroll_docs(4),
          ["<C-y>"] = cmp_mapping {
            i = cmp_mapping.confirm { behavior = cmp_types.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm { behavior = cmp_types.ConfirmBehavior.Replace, select = false }
              else
                fallback()
              end
            end,
          },
          ["<Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif utils.jumpable(1) then
              luasnip.jump(1)
            elseif utils.has_words_before() then
              -- cmp.complete()
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp_mapping.complete(),
          ["<C-e>"] = cmp_mapping.abort(),
          ["<CR>"] = cmp_mapping(function(fallback)
            if cmp.visible() then
              local confirm_opts = vim.deepcopy({
                behavior = cmp_types.ConfirmBehavior.Replace,
                select = false,
              })               -- avoid mutating the original opts below
              local is_insert_mode = function()
                return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
              end
              if is_insert_mode() then               -- prevent overwriting brackets
                confirm_opts.behavior = cmp_types.ConfirmBehavior.Insert
              end
              local entry = cmp.get_selected_entry()
              local is_copilot = entry and entry.source.name == "copilot"
              if is_copilot then
                confirm_opts.behavior = cmp_types.ConfirmBehavior.Replace
                confirm_opts.select = true
              end
              if cmp.confirm(confirm_opts) then
                return                 -- success, exit early
              end
            end
            fallback()             -- if not exited early, always fallback
          end),
        },
      }
    end
  },

  -- inlay hints
  {
    'simrat39/inlay-hints.nvim',
    config = function()
      require("inlay-hints").setup({
        only_current_line = false,
        eol = {
          right_align = false,
        }
      })
    end
  },

  ------------------------------------
  -- language specific: Rust and Go --
  ------------------------------------
  {
    "simrat39/rust-tools.nvim",
    lazy = false,
    enabled = true,
    config = function()
      local ih = require("inlay-hints")
      require("rust-tools").setup({
        server = {
          settings = {
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              lens = {
                enable = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
        tools = {
          executor = require("rust-tools/executors").termopen,           -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = false,
            only_current_line = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = "rounded",
          },
          on_initialized = function()
            ih.set_all()

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
              pattern = { "*.rs" },
              callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      }
    end,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "leoluz/nvim-dap-go"
    },
    lazy = false,
    config = function()
      local gopher = require("gopher")
      gopher.setup({
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
        },
        goimport = "gopls",
        gofmt = "gopls",
      })
    end
  },
  {
    "ray-x/go.nvim",
    dependencies = {     -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        go = "go",                        -- go command, can be go[default] or go1.18beta1
        goimport = "gopls",               -- goimport command, can be gopls[default] or goimport
        fillstruct = "gopls",             -- can be nil (use fillstruct, slower) and gopls
        gofmt = "gofumpt",                -- gofmt cmd,
        max_line_len = 120,               -- max line length in goline format
        tag_transform = false,            -- tag_transfer  check gomodifytags for details
        test_template = "",               -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
        test_template_dir = "",           -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
        comment_placeholder = "",         -- comment_placeholder your cool placeholder e.g. ﳑ       
        icons = false,                    --{breakpoint = '🧘', currentpos = '🏃'},  -- setup to `false` to disable icons setup
        verbose = false,                  -- output loginf in messages
        lsp_cfg = true,                   -- true: use non-default gopls setup specified in go/lsp.lua
        -- false: do nothing
        -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
        --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
        lsp_gofumpt = false,         -- true: set default gofmt in gopls format to gofumpt
        lsp_diag_underline = false,
        --      when lsp_cfg is true
        -- if lsp_on_attach is a function: use this function as on_attach function for gopls
        lsp_codelens = true,                                                                                 -- set to false to disable codelens, true by default
        lsp_keymaps = false,                                                                                 -- set to false to disable gopls/lsp keymap
        lsp_diag_hdlr = true,                                                                                -- hook lsp diag handler
        lsp_diag_virtual_text = { space = 0, prefix = require('config.icons').ui.ArrowCircleRight },         -- virtual text setup
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = true,
        lsp_document_formatting = false,
        -- set to true: use gopls to format
        -- false if you want to use other formatter tool(e.g. efm, nulls)
        lsp_inlay_hints = {
          enable = true,
          -- Only show inlay hints for the current line
          only_current_line = false,
          -- Event which triggers a refersh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = "CursorHold",
          -- whether to show variable name before type hints with the inlay hints or not
          -- default: false
          show_variable_name = true,
          -- prefix for parameter hints
          parameter_hints_prefix = " ",
          show_parameter_hints = true,
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = "=> ",
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 6,
          -- The color of the hints
          highlight = "Comment",
        },
        gopls_cmd = nil,                  -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
        gopls_remote_auto = true,         -- add -remote=auto to gopls
        gocoverage_sign = "█",
        dap_debug = false,                -- set to false to disable dap
        dap_debug_keymap = false,         -- true: use keymap for debugger defined in go/dap.lua
        -- false: do not use keymap in go/dap.lua.  you must define your own.
        dap_debug_gui = false,            -- set to true to enable dap gui, highly recommended
        dap_debug_vt = false,             -- set to true to enable dap virtual text
        build_tags = "",                  -- set default build tags
        textobjects = true,               -- enable default text jobects through treesittter-text-objects
        test_runner = "go",               -- richgo, go test, richgo, dlv, ginkgo
        run_in_floaterm = false,          -- set to true to run in float window.
        -- float term recommended if you use richgo/ginkgo with terminal color
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'     -- if you need to install/update all binaries
  }
}
