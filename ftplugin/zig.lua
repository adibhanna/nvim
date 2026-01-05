-- ════════════════════════════════════════════════════════════════════════════
-- Zig Tools - Custom commands for Zig development
-- ════════════════════════════════════════════════════════════════════════════

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO)
end

local function run_cmd(cmd, opts)
    opts = opts or {}
    local on_exit = opts.on_exit or function() end
    local cwd = opts.cwd or vim.fn.getcwd()

    vim.system(cmd, { text = true, cwd = cwd }, function(result)
        vim.schedule(function()
            on_exit(result)
        end)
    end)
end

local function get_project_root()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/build.zig") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return vim.fn.getcwd()
end

-- ════════════════════════════════════════════════════════════════════════════
-- Build & Run
-- ════════════════════════════════════════════════════════════════════════════

-- ZigBuild: zig build
vim.api.nvim_buf_create_user_command(0, "ZigBuild", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig build " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build" })

-- ZigBuildRelease: zig build -Doptimize=ReleaseFast
vim.api.nvim_buf_create_user_command(0, "ZigBuildRelease", function()
    vim.cmd("split | terminal zig build -Doptimize=ReleaseFast")
end, { desc = "zig build -Doptimize=ReleaseFast" })

-- ZigBuildSafe: zig build -Doptimize=ReleaseSafe
vim.api.nvim_buf_create_user_command(0, "ZigBuildSafe", function()
    vim.cmd("split | terminal zig build -Doptimize=ReleaseSafe")
end, { desc = "zig build -Doptimize=ReleaseSafe" })

-- ZigRun: zig build run
vim.api.nvim_buf_create_user_command(0, "ZigRun", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "zig build run" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build run" })

-- ZigRunFile: zig run <current file>
vim.api.nvim_buf_create_user_command(0, "ZigRunFile", function(opts)
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "zig run " .. filepath .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig run <current file>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Testing
-- ════════════════════════════════════════════════════════════════════════════

-- ZigTest: zig build test
vim.api.nvim_buf_create_user_command(0, "ZigTest", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig build test " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig build test" })

-- ZigTestFile: zig test <current file>
vim.api.nvim_buf_create_user_command(0, "ZigTestFile", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local cmd_str = "zig test " .. filepath
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "zig test <current file>" })

-- ZigTestFilter: zig build test with filter
vim.api.nvim_buf_create_user_command(0, "ZigTestFilter", function(opts)
    if opts.args == "" then
        notify("Usage: ZigTestFilter <test_name>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig build test -- --test-filter " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig build test with filter" })

-- ════════════════════════════════════════════════════════════════════════════
-- Code Quality
-- ════════════════════════════════════════════════════════════════════════════

-- ZigFmt: zig fmt
vim.api.nvim_buf_create_user_command(0, "ZigFmt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    notify("Running: zig fmt")
    run_cmd({ "zig", "fmt", filepath }, {
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("zig fmt: completed")
            else
                notify("zig fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig fmt <current file>" })

-- ZigFmtAll: zig fmt on all .zig files
vim.api.nvim_buf_create_user_command(0, "ZigFmtAll", function()
    notify("Running: zig fmt on project")
    run_cmd({ "zig", "fmt", "." }, {
        cwd = get_project_root(),
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("zig fmt: completed")
            else
                notify("zig fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig fmt on project" })

-- ZigFmtCheck: zig fmt --check
vim.api.nvim_buf_create_user_command(0, "ZigFmtCheck", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    notify("Running: zig fmt --check")
    run_cmd({ "zig", "fmt", "--check", filepath }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("zig fmt --check: OK")
            else
                notify("zig fmt --check: formatting needed", vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "zig fmt --check" })

-- ════════════════════════════════════════════════════════════════════════════
-- Project Management
-- ════════════════════════════════════════════════════════════════════════════

-- ZigInit: zig init
vim.api.nvim_buf_create_user_command(0, "ZigInit", function()
    notify("Running: zig init")
    run_cmd({ "zig", "init" }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("zig init: completed")
                vim.cmd("checktime")
            else
                notify("zig init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig init" })

-- ZigFetch: zig fetch (for build.zig.zon dependencies)
vim.api.nvim_buf_create_user_command(0, "ZigFetch", function(opts)
    if opts.args == "" then
        notify("Usage: ZigFetch <url>", vim.log.levels.WARN)
        return
    end
    notify("Running: zig fetch " .. opts.args)
    run_cmd({ "zig", "fetch", opts.args }, {
        cwd = get_project_root(),
        on_exit = function(result)
            if result.code == 0 then
                local hash = result.stdout:gsub("%s+", "")
                notify("Hash: " .. hash)
                -- Copy to clipboard
                vim.fn.setreg("+", hash)
                notify("Hash copied to clipboard")
            else
                notify("zig fetch failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = 1, desc = "zig fetch <url>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Documentation & Help
-- ════════════════════════════════════════════════════════════════════════════

-- ZigDoc: open Zig documentation
vim.api.nvim_buf_create_user_command(0, "ZigDoc", function(opts)
    local query = opts.args ~= "" and opts.args or ""
    local url = "https://ziglang.org/documentation/master/"
    if query ~= "" then
        url = "https://ziglang.org/documentation/master/#" .. query
    end
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open Zig documentation" })

-- ZigStdDoc: open Zig std lib documentation
vim.api.nvim_buf_create_user_command(0, "ZigStdDoc", function(opts)
    local query = opts.args ~= "" and opts.args or ""
    local url = "https://ziglang.org/documentation/master/std/"
    if query ~= "" then
        url = url .. "#" .. query
    end
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open Zig std lib documentation" })

-- ZigHelp: zig help
vim.api.nvim_buf_create_user_command(0, "ZigHelp", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "zig help " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "zig help" })

-- ZigVersion: zig version
vim.api.nvim_buf_create_user_command(0, "ZigVersion", function()
    run_cmd({ "zig", "version" }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("Zig version: " .. result.stdout:gsub("%s+", ""))
            else
                notify("Failed to get version", vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "zig version" })

-- ════════════════════════════════════════════════════════════════════════════
-- Compilation & Analysis
-- ════════════════════════════════════════════════════════════════════════════

-- ZigAst: show AST of current file
vim.api.nvim_buf_create_user_command(0, "ZigAst", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == "" then
        notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end
    local cmd_str = "zig ast-check " .. filepath
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "zig ast-check <current file>" })

-- ZigTranslateC: translate C header to Zig
vim.api.nvim_buf_create_user_command(0, "ZigTranslateC", function(opts)
    if opts.args == "" then
        notify("Usage: ZigTranslateC <header.h>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig translate-c " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig translate-c <header>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Build Steps
-- ════════════════════════════════════════════════════════════════════════════

-- ZigBuildSteps: show available build steps
vim.api.nvim_buf_create_user_command(0, "ZigBuildSteps", function()
    vim.cmd("split | terminal zig build --help")
end, { desc = "Show available build steps" })

-- ZigBuildStep: run specific build step
vim.api.nvim_buf_create_user_command(0, "ZigBuildStep", function(opts)
    if opts.args == "" then
        notify("Usage: ZigBuildStep <step>", vim.log.levels.WARN)
        return
    end
    local cmd_str = "zig build " .. opts.args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = 1, desc = "zig build <step>" })

-- ════════════════════════════════════════════════════════════════════════════
-- Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- ZigAlt: switch to/from test file
vim.api.nvim_buf_create_user_command(0, "ZigAlt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t:r")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    -- Check if we're in a test file
    if filename:match("_test$") or filename == "test" then
        -- Try to find the source file
        local source = filepath:gsub("_test%.zig$", ".zig")
        if source == filepath then
            source = dir .. "/main.zig"
        end
        if vim.fn.filereadable(source) == 1 then
            vim.cmd("edit " .. source)
        else
            notify("Source file not found", vim.log.levels.WARN)
        end
    else
        -- Try to find the test file
        local test_file = filepath:gsub("%.zig$", "_test.zig")
        local test_dir = dir .. "/test.zig"
        if vim.fn.filereadable(test_file) == 1 then
            vim.cmd("edit " .. test_file)
        elseif vim.fn.filereadable(test_dir) == 1 then
            vim.cmd("edit " .. test_dir)
        else
            notify("Test file not found: " .. test_file, vim.log.levels.WARN)
        end
    end
end, { desc = "Switch between source and test file" })

-- ZigAltV: switch in vertical split
vim.api.nvim_buf_create_user_command(0, "ZigAltV", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t:r")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    if filename:match("_test$") or filename == "test" then
        local source = filepath:gsub("_test%.zig$", ".zig")
        if source == filepath then
            source = dir .. "/main.zig"
        end
        if vim.fn.filereadable(source) == 1 then
            vim.cmd("vsplit " .. source)
        else
            notify("Source file not found", vim.log.levels.WARN)
        end
    else
        local test_file = filepath:gsub("%.zig$", "_test.zig")
        if vim.fn.filereadable(test_file) == 1 then
            vim.cmd("vsplit " .. test_file)
        else
            notify("Test file not found: " .. test_file, vim.log.levels.WARN)
        end
    end
end, { desc = "Switch to alt file in vsplit" })
