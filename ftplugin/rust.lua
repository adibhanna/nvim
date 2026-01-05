-- ════════════════════════════════════════════════════════════════════════════
-- Rust Tools - Custom commands for Rust development
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

local function get_crate_root()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dir = vim.fn.fnamemodify(filepath, ":h")
    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/Cargo.toml") == 1 then
            return dir
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return vim.fn.getcwd()
end

-- ════════════════════════════════════════════════════════════════════════════
-- Build & Run
-- ════════════════════════════════════════════════════════════════════════════

-- CargoBuild: cargo build
vim.api.nvim_buf_create_user_command(0, "CargoBuild", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo build " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo build" })

-- CargoBuildRelease: cargo build --release
vim.api.nvim_buf_create_user_command(0, "CargoBuildRelease", function()
    vim.cmd("split | terminal cargo build --release")
end, { desc = "cargo build --release" })

-- CargoRun: cargo run
vim.api.nvim_buf_create_user_command(0, "CargoRun", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run" })

-- CargoRunRelease: cargo run --release
vim.api.nvim_buf_create_user_command(0, "CargoRunRelease", function(opts)
    local args = opts.args ~= "" and " -- " .. opts.args or ""
    local cmd_str = "cargo run --release" .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo run --release" })

-- ════════════════════════════════════════════════════════════════════════════
-- Testing
-- ════════════════════════════════════════════════════════════════════════════

-- CargoTest: cargo test
vim.api.nvim_buf_create_user_command(0, "CargoTest", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo test " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo test" })

-- CargoTestFunc: test function under cursor
vim.api.nvim_buf_create_user_command(0, "CargoTestFunc", function()
    local func_name = nil
    local node = vim.treesitter.get_node()
    while node do
        if node:type() == "function_item" then
            local name_node = node:field("name")[1]
            if name_node then
                func_name = vim.treesitter.get_node_text(name_node, 0)
                break
            end
        end
        node = node:parent()
    end

    if not func_name then
        notify("Cursor not in a function", vim.log.levels.WARN)
        return
    end

    local cmd_str = string.format("cargo test %s -- --exact --nocapture", func_name)
    vim.cmd("split | terminal " .. cmd_str)
end, { desc = "Test function under cursor" })

-- ════════════════════════════════════════════════════════════════════════════
-- Code Quality
-- ════════════════════════════════════════════════════════════════════════════

-- CargoCheck: cargo check
vim.api.nvim_buf_create_user_command(0, "CargoCheck", function()
    notify("Running: cargo check")
    run_cmd({ "cargo", "check", "--message-format=short" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo check: OK")
            else
                notify("cargo check failed:\n" .. (result.stderr or result.stdout), vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "cargo check" })

-- CargoClippy: cargo clippy
vim.api.nvim_buf_create_user_command(0, "CargoClippy", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo clippy " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo clippy" })

-- CargoFmt: cargo fmt
vim.api.nvim_buf_create_user_command(0, "CargoFmt", function()
    notify("Running: cargo fmt")
    run_cmd({ "cargo", "fmt" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                vim.cmd("checktime")
                notify("cargo fmt: completed")
            else
                notify("cargo fmt failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo fmt" })

-- CargoFmtCheck: cargo fmt --check
vim.api.nvim_buf_create_user_command(0, "CargoFmtCheck", function()
    notify("Running: cargo fmt --check")
    run_cmd({ "cargo", "fmt", "--check" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo fmt --check: OK")
            else
                notify("cargo fmt --check: formatting needed\n" .. (result.stdout or ""), vim.log.levels.WARN)
            end
        end,
    })
end, { desc = "cargo fmt --check" })

-- ════════════════════════════════════════════════════════════════════════════
-- Dependencies
-- ════════════════════════════════════════════════════════════════════════════

-- CargoAdd: cargo add
vim.api.nvim_buf_create_user_command(0, "CargoAdd", function(opts)
    if opts.args == "" then
        notify("Usage: CargoAdd <crate>", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo add " .. opts.args)
    run_cmd({ "cargo", "add", opts.args }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("Added: " .. opts.args)
                vim.cmd("checktime")
            else
                notify("cargo add failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "+", desc = "cargo add <crate>" })

-- CargoRemove: cargo remove
vim.api.nvim_buf_create_user_command(0, "CargoRemove", function(opts)
    if opts.args == "" then
        notify("Usage: CargoRemove <crate>", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo remove " .. opts.args)
    run_cmd({ "cargo", "remove", opts.args }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("Removed: " .. opts.args)
                vim.cmd("checktime")
            else
                notify("cargo remove failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = 1, desc = "cargo remove <crate>" })

-- CargoUpdate: cargo update
vim.api.nvim_buf_create_user_command(0, "CargoUpdate", function()
    notify("Running: cargo update")
    run_cmd({ "cargo", "update" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo update: completed")
                vim.cmd("checktime")
            else
                notify("cargo update failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo update" })

-- CargoTree: cargo tree
vim.api.nvim_buf_create_user_command(0, "CargoTree", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo tree " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo tree" })

-- ════════════════════════════════════════════════════════════════════════════
-- Documentation
-- ════════════════════════════════════════════════════════════════════════════

-- CargoDoc: cargo doc
vim.api.nvim_buf_create_user_command(0, "CargoDoc", function(opts)
    local open = opts.bang and " --open" or ""
    notify("Running: cargo doc" .. open)
    run_cmd({ "cargo", "doc", open ~= "" and "--open" or nil }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo doc: completed")
            else
                notify("cargo doc failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { bang = true, desc = "cargo doc (! to open)" })

-- RustDoc: open docs.rs for word under cursor
vim.api.nvim_buf_create_user_command(0, "RustDoc", function(opts)
    local crate = opts.args ~= "" and opts.args or vim.fn.expand("<cword>")
    local url = "https://docs.rs/" .. crate
    local open_cmd = vim.fn.has("mac") == 1 and "open" or "xdg-open"
    vim.fn.system({ open_cmd, url })
    notify("Opening: " .. url)
end, { nargs = "?", desc = "Open docs.rs for crate" })

-- ════════════════════════════════════════════════════════════════════════════
-- Project Management
-- ════════════════════════════════════════════════════════════════════════════

-- CargoNew: cargo new
vim.api.nvim_buf_create_user_command(0, "CargoNew", function(opts)
    if opts.args == "" then
        notify("Usage: CargoNew <name> [--lib]", vim.log.levels.WARN)
        return
    end
    notify("Running: cargo new " .. opts.args)
    run_cmd({ "cargo", "new", unpack(vim.split(opts.args, " ")) }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("Created: " .. opts.args)
            else
                notify("cargo new failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "+", desc = "cargo new <name>" })

-- CargoInit: cargo init
vim.api.nvim_buf_create_user_command(0, "CargoInit", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    notify("Running: cargo init " .. args)
    run_cmd({ "cargo", "init", unpack(vim.split(args, " ")) }, {
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo init: completed")
                vim.cmd("checktime")
            else
                notify("cargo init failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { nargs = "?", desc = "cargo init" })

-- CargoClean: cargo clean
vim.api.nvim_buf_create_user_command(0, "CargoClean", function()
    notify("Running: cargo clean")
    run_cmd({ "cargo", "clean" }, {
        cwd = get_crate_root(),
        on_exit = function(result)
            if result.code == 0 then
                notify("cargo clean: completed")
            else
                notify("cargo clean failed:\n" .. (result.stderr or result.stdout), vim.log.levels.ERROR)
            end
        end,
    })
end, { desc = "cargo clean" })

-- ════════════════════════════════════════════════════════════════════════════
-- Utilities
-- ════════════════════════════════════════════════════════════════════════════

-- CargoExpand: cargo expand (requires cargo-expand)
vim.api.nvim_buf_create_user_command(0, "CargoExpand", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo expand " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo expand (macro expansion)" })

-- CargoAudit: cargo audit (requires cargo-audit)
vim.api.nvim_buf_create_user_command(0, "CargoAudit", function()
    vim.cmd("split | terminal cargo audit")
end, { desc = "cargo audit (security vulnerabilities)" })

-- CargoOutdated: cargo outdated (requires cargo-outdated)
vim.api.nvim_buf_create_user_command(0, "CargoOutdated", function()
    vim.cmd("split | terminal cargo outdated")
end, { desc = "cargo outdated" })

-- CargoBench: cargo bench
vim.api.nvim_buf_create_user_command(0, "CargoBench", function(opts)
    local args = opts.args ~= "" and opts.args or ""
    local cmd_str = "cargo bench " .. args
    vim.cmd("split | terminal " .. cmd_str)
end, { nargs = "?", desc = "cargo bench" })

-- ════════════════════════════════════════════════════════════════════════════
-- Navigation
-- ════════════════════════════════════════════════════════════════════════════

-- RustAlt: switch between source and test
vim.api.nvim_buf_create_user_command(0, "RustAlt", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local filename = vim.fn.fnamemodify(filepath, ":t")
    local dir = vim.fn.fnamemodify(filepath, ":h")

    -- Check if we're in a tests module or main source
    if filename == "mod.rs" and dir:match("/tests$") then
        -- In tests/mod.rs, go to lib.rs or main.rs
        local parent = vim.fn.fnamemodify(dir, ":h")
        local lib = parent .. "/lib.rs"
        local main = parent .. "/main.rs"
        if vim.fn.filereadable(lib) == 1 then
            vim.cmd("edit " .. lib)
        elseif vim.fn.filereadable(main) == 1 then
            vim.cmd("edit " .. main)
        else
            notify("No lib.rs or main.rs found", vim.log.levels.WARN)
        end
    elseif filename == "lib.rs" or filename == "main.rs" then
        -- Go to tests/mod.rs or create inline test module
        local tests_dir = dir .. "/tests"
        local tests_mod = tests_dir .. "/mod.rs"
        if vim.fn.filereadable(tests_mod) == 1 then
            vim.cmd("edit " .. tests_mod)
        else
            notify("No tests/mod.rs found. Consider inline #[cfg(test)] module.", vim.log.levels.INFO)
        end
    else
        notify("RustAlt works best from lib.rs/main.rs", vim.log.levels.INFO)
    end
end, { desc = "Switch between source and tests" })

-- ════════════════════════════════════════════════════════════════════════════
-- Cargo Subcommand Installation
-- ════════════════════════════════════════════════════════════════════════════

local cargo_tools = {
    { name = "cargo-expand", desc = "Macro expansion" },
    { name = "cargo-audit", desc = "Security audit" },
    { name = "cargo-outdated", desc = "Check outdated deps" },
    { name = "cargo-edit", desc = "Add/remove/upgrade deps" },
    { name = "cargo-watch", desc = "Watch for changes" },
    { name = "cargo-nextest", desc = "Better test runner" },
    { name = "cargo-flamegraph", desc = "Flamegraph profiling" },
}

local function install_cargo_tools_async(tools, index, on_complete)
    index = index or 1
    if index > #tools then
        on_complete()
        return
    end

    local tool = tools[index]
    notify(string.format("[%d/%d] Installing: %s", index, #tools, tool.name))

    vim.system({ "cargo", "install", tool.name }, { text = true }, function(result)
        vim.schedule(function()
            if result.code ~= 0 then
                notify(string.format("Failed to install %s: %s", tool.name, result.stderr or ""), vim.log.levels.ERROR)
            end
            install_cargo_tools_async(tools, index + 1, on_complete)
        end)
    end)
end

-- CargoInstallTools: install useful cargo subcommands
vim.api.nvim_buf_create_user_command(0, "CargoInstallTools", function()
    notify("Installing Cargo tools (this may take a few minutes)...")
    install_cargo_tools_async(cargo_tools, 1, function()
        notify("All Cargo tools installed!", vim.log.levels.INFO)
    end)
end, { desc = "Install useful cargo subcommands" })

-- CargoInstallTool: install a specific cargo tool
vim.api.nvim_buf_create_user_command(0, "CargoInstallTool", function(opts)
    if opts.args == "" then
        local tool_list = {}
        for _, t in ipairs(cargo_tools) do
            table.insert(tool_list, string.format("  %s - %s", t.name, t.desc))
        end
        notify("Available tools:\n" .. table.concat(tool_list, "\n"), vim.log.levels.INFO)
        return
    end
    notify("Installing: " .. opts.args .. "...")
    vim.system({ "cargo", "install", opts.args }, { text = true }, function(result)
        vim.schedule(function()
            if result.code == 0 then
                notify("Installed: " .. opts.args, vim.log.levels.INFO)
            else
                notify("Failed to install " .. opts.args .. ": " .. (result.stderr or ""), vim.log.levels.ERROR)
            end
        end)
    end)
end, {
    nargs = "?",
    complete = function()
        return vim.tbl_map(function(t) return t.name end, cargo_tools)
    end,
    desc = "Install a specific cargo tool"
})
