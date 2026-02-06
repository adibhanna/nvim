-- Linting: nvim-lint configuration
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    local lint_progress = {}

    -- ══════════════════════════════════════════════════════════════════════════
    -- Custom Linter Configurations
    -- ══════════════════════════════════════════════════════════════════════════

    -- Customize golangci-lint
    local golangcilint = lint.linters.golangcilint
    golangcilint.ignore_exitcode = true
    golangcilint.args = {
      "run",
      "--out-format=json",
      "--issues-exit-code=0",
    }

    -- Configure luacheck
    local luacheck = lint.linters.luacheck
    luacheck.args = {
      "--formatter",
      "plain",
      "--codes",
      "--ranges",
      "--filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
      "-",
    }
    luacheck.stdin = true

    -- Configure eslint_d
    if lint.linters.eslint_d then
      lint.linters.eslint_d.args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
    end

    -- Configure Laravel Pint (custom linter)
    lint.linters.pint = {
      name = "pint",
      cmd = "pint",
      stdin = false,
      args = { "--test", "--json" },
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        if not output or output == "" then
          return diagnostics
        end

        local ok, decoded = pcall(vim.json.decode, output)
        if ok and decoded and decoded.files then
          for file, issues in pairs(decoded.files) do
            if type(issues) == "table" and #issues > 0 then
              for _, issue in ipairs(issues) do
                table.insert(diagnostics, {
                  lnum = issue.line and (issue.line - 1) or 0,
                  col = issue.column or 0,
                  message = issue.message or "Style issue",
                  severity = vim.diagnostic.severity.WARN,
                  source = "pint",
                })
              end
            end
          end
        elseif string.find(output, "FAIL") or string.find(output, "differs") then
          table.insert(diagnostics, {
            lnum = 0,
            col = 0,
            message = "Code style issues found - run formatter to fix",
            severity = vim.diagnostic.severity.WARN,
            source = "pint",
          })
        end
        return diagnostics
      end,
    }

    -- ══════════════════════════════════════════════════════════════════════════
    -- Linters by Filetype
    -- ══════════════════════════════════════════════════════════════════════════
    lint.linters_by_ft = {
      go = { "golangcilint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      svelte = { "eslint_d" },
      html = { "htmlhint" },
      css = { "stylelint" },
      scss = { "stylelint" },
      less = { "stylelint" },
      lua = { "luacheck" },
      python = { "ruff", "mypy" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      fish = { "fish" },
      php = { "phpstan" },
      blade = { "phpstan" },
      ruby = { "rubocop" },
      eruby = { "erb_lint" },
      rust = { "clippy" },
      yaml = { "yamllint" },
      ["yaml.docker-compose"] = { "yamllint" },
      json = { "jsonlint" },
      jsonc = { "jsonlint" },
      markdown = { "markdownlint" },
      dockerfile = { "hadolint" },
      terraform = { "tflint", "tfsec" },
      tf = { "tflint", "tfsec" },
      sql = { "sqlfluff" },
      proto = { "buf_lint" },
      make = { "checkmake" },
      c = { "cppcheck", "cpplint" },
      cpp = { "cppcheck", "cpplint" },
    }

    -- ══════════════════════════════════════════════════════════════════════════
    -- Performance Optimizations
    -- ══════════════════════════════════════════════════════════════════════════

    local debounce_timer = nil
    local function debounce_lint(ms)
      if debounce_timer then
        vim.fn.timer_stop(debounce_timer)
      end
      debounce_timer = vim.fn.timer_start(ms or 250, function()
        vim.schedule(function()
          lint.try_lint()
        end)
      end)
    end

    local function is_file_too_large()
      local max_size = 1024 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
      return ok and stats and stats.size > max_size
    end

    local function should_lint(bufnr)
      bufnr = bufnr or 0
      local buftype = vim.bo[bufnr].buftype
      if buftype ~= "" and buftype ~= "acwrite" then
        return false
      end
      if is_file_too_large() then
        return false
      end
      local ft = vim.bo[bufnr].filetype
      local linters = lint.linters_by_ft[ft]
      return linters and #linters > 0
    end

    -- ══════════════════════════════════════════════════════════════════════════
    -- Auto-lint Configuration
    -- ══════════════════════════════════════════════════════════════════════════
    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) then
          if args.event == "BufWritePost" then
            lint.try_lint()
          else
            debounce_lint(100)
          end
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "TextChanged" }, {
      group = lint_augroup,
      callback = function(args)
        if should_lint(args.buf) and vim.bo.filetype ~= "TelescopePrompt" then
          debounce_lint(1000)
        end
      end,
    })

    -- ══════════════════════════════════════════════════════════════════════════
    -- Commands and Keybindings
    -- ══════════════════════════════════════════════════════════════════════════

    vim.api.nvim_create_user_command("LintInfo", function()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft] or {}
      local running = lint_progress[vim.api.nvim_get_current_buf()] or false

      print(string.format("Filetype: %s", ft))
      print(
        string.format(
          "Configured linters: %s",
          #linters > 0 and table.concat(linters, ", ") or "none"
        )
      )
      print(string.format("Status: %s", running and "running..." or "idle"))

      local installed, missing = {}, {}
      for _, linter in ipairs(linters) do
        local cmd = lint.linters[linter] and lint.linters[linter].cmd
        if cmd then
          if vim.fn.executable(cmd) == 1 then
            table.insert(installed, linter)
          else
            table.insert(missing, linter)
          end
        end
      end
      if #installed > 0 then
        print(string.format("Installed: %s", table.concat(installed, ", ")))
      end
      if #missing > 0 then
        print(string.format("Missing: %s", table.concat(missing, ", ")))
      end
    end, { desc = "Show linting information" })

    vim.api.nvim_create_user_command("LintToggle", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr].lint_enabled = not vim.b[bufnr].lint_enabled
      vim.notify(
        string.format("Linting %s", vim.b[bufnr].lint_enabled and "enabled" or "disabled"),
        vim.log.levels.INFO
      )
    end, { desc = "Toggle linting" })

    vim.keymap.set("n", "<leader>ll", function()
      if should_lint() then
        lint.try_lint()
        vim.notify("Linting...", vim.log.levels.INFO)
      else
        vim.notify("No linters configured", vim.log.levels.WARN)
      end
    end, { desc = "Lint" })

    vim.keymap.set("n", "<leader>lI", "<cmd>LintInfo<cr>", { desc = "Lint Info" })
    vim.keymap.set("n", "<leader>lL", "<cmd>LintToggle<cr>", { desc = "Toggle Lint" })

    vim.keymap.set("n", "<leader>lC", function()
      local ns = require("lint").get_namespace(vim.bo.filetype)
      vim.diagnostic.reset(ns)
      vim.notify("Lint cleared", vim.log.levels.INFO)
    end, { desc = "Clear Lint" })
  end,
}
