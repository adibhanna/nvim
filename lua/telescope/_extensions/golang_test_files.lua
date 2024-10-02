local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local scan = require("plenary.scandir")
local path = require("plenary.path")

-- Store test results
local test_results = {}

local function run_go_test(file_path, callback)
    local cmd = string.format("go test -v %s", file_path)
    local output = ""
    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            for _, line in ipairs(data) do
                if line ~= "" then
                    output = output .. line .. "\n"
                    print(line)
                end
            end
        end,
        on_stderr = function(_, data)
            for _, line in ipairs(data) do
                if line ~= "" then
                    output = output .. line .. "\n"
                    print(line)
                end
            end
        end,
        on_exit = function(_, exit_code)
            local passed = exit_code == 0
            test_results[file_path] = passed
            if passed then
                print("Tests passed successfully!")
            else
                print("Tests failed with exit code: " .. exit_code)
            end
            if callback then
                callback(passed, output)
            end
        end,
    })
end

local function golang_test_files(opts)
    opts = opts or {}

    -- Get the current buffer's file path
    local current_file = vim.fn.expand("%:p")
    local current_dir = vim.fn.expand("%:p:h")
    local current_file_name = vim.fn.expand("%:t:r")
    local corresponding_test_file = path:new(current_dir, current_file_name .. "_test.go").filename

    -- Find the project root
    local project_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if not project_root then
        print("Not in a git repository")
        return
    end

    -- Find all Golang test files
    local find_command = scan.scan_dir(project_root, {
        search_pattern = ".*_test%.go$",
        respect_gitignore = true
    })

    -- Prepare results table
    local results = {}

    -- Add corresponding test file first if it exists
    if vim.fn.filereadable(corresponding_test_file) == 1 then
        table.insert(results, corresponding_test_file)
    end

    -- Add all other test files
    for _, file in ipairs(find_command) do
        if file ~= corresponding_test_file then
            table.insert(results, file)
        end
    end

    local function make_display(entry)
        local display = vim.fn.fnamemodify(entry, ":.:") -- relative path
        if entry == corresponding_test_file then
            display = display .. " (Current)"
        end
        if test_results[entry] == true then
            display = display .. " ✅"
        elseif test_results[entry] == false then
            display = display .. " ❌"
        end
        return display
    end

    local function make_entry(entry)
        return {
            value = entry,
            display = make_display(entry),
            ordinal = entry,
            path = entry,
        }
    end

    local custom_sorter = function(opts)
        opts = opts or {}
        return require("telescope.sorters").Sorter:new {
            scoring_function = function() return 0 end,
            -- This sorter does nothing, preserving the original order
        }
    end

    local run_test_action = function(prompt_bufnr)
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local selected_index = current_picker:get_index(current_picker:get_selection_row())

        if vim.fn.filereadable(selection.value) == 1 then
            run_go_test(selection.value, function()
                current_picker:refresh(finders.new_table {
                    results = results,
                    entry_maker = make_entry,
                }, {
                    reset_prompt = false,
                })
                vim.schedule(function()
                    current_picker:set_selection(selected_index)
                end)
            end)
        else
            print("Cannot run tests: File does not exist.")
        end
    end

    local picker = pickers.new(opts, {
        prompt_title = "Golang Test Files",
        finder = finders.new_table {
            results = results,
            entry_maker = make_entry,
        },
        sorter = custom_sorter(),
        previewer = conf.file_previewer(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("edit " .. selection.value)
            end)

            map("n", "<leader>T", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("edit " .. selection.value)
            end)

            map("n", "<C-e>", run_test_action)
            map("i", "<C-e>", run_test_action)

            return true
        end,
    })

    picker:find()
end

-- Add the picker to Telescope extensions
-- return require("telescope").register_extension({
--     exports = {
--         golang_test_files = golang_test_files,
--     },
-- })
