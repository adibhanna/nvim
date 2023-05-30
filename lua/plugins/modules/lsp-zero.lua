return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = false,
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required

      { 'onsails/lspkind.nvim' },
      { 'b0o/schemastore.nvim' }
    },
    config = function()
      local lsp = require('lsp-zero').preset("recommended")

      lsp.ensure_installed({
        'tsserver',
        'eslint',
        'rust_analyzer',
        'gopls',
        'lua_ls',
        'jsonls',
        'bashls',
        'vimls'
      })

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      lsp.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
          error = "E",
          warn = "W",
          hint = "H",
          info = "I",
        },
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          source = "always",
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
      })

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })

      lspconfig.jsonls.setup({
        settings = {
          json = {
            schema = require('schemastore').json.schemas(),
            validate = { enable = true },
          }
        }
      })

      require('lspconfig').eslint.setup({
        filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
        settings = {
          workingDirectory = { mode = 'auto' },
          format = { enable = true },
          lint = { enable = true },
        },
      })

      lsp.skip_server_setup({ 'rust_analyzer' })

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
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          }),
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
              }) -- avoid mutating the original opts below
              local is_insert_mode = function()
                return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
              end
              if is_insert_mode() then -- prevent overwriting brackets
                confirm_opts.behavior = cmp_types.ConfirmBehavior.Insert
              end
              local entry = cmp.get_selected_entry()
              local is_copilot = entry and entry.source.name == "copilot"
              if is_copilot then
                confirm_opts.behavior = cmp_types.ConfirmBehavior.Replace
                confirm_opts.select = true
              end
              if cmp.confirm(confirm_opts) then
                return -- success, exit early
              end
            end
            fallback() -- if not exited early, always fallback
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
    lazy = true,
    enabled = true,
    event = { "BufRead", "BufReadPre", "BufNewFile" },
    config = function()
      local ih = require("inlay-hints")
      require("rust-tools").setup({
        server = {
          settings = {
            ["rust-analyzer"] = {
              lens = {
                enable = true,
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              check = {
                enable = true,
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
        tools = {
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
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
    enabled = true,
    version = "v0.3.0",
    lazy = true,
    event = { "BufRead", "BufReadPre", "BufNewFile" },
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
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  }
}
