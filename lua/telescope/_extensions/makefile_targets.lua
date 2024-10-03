local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function extract_makefile_targets(makefile_path)
    local targets = {}
    for line in io.lines(makefile_path) do
        local target = line:match("^([%w-]+):")
        if target then
            table.insert(targets, target)
        end
    end
    return targets
end

local function run_make_command(target)
    local command = "make " .. target
    local output = vim.fn.system(command)

    -- Open a new split window and show the output
    vim.cmd("new")
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_name(buf, "Make Output: " .. target)
end

local makefile_targets = function(opts)
    opts = opts or {}
    local makefile_path = vim.fn.findfile("Makefile", ".;")

    if makefile_path == "" then
        print("No Makefile found in the current directory or its parents")
        return
    end

    local targets = extract_makefile_targets(makefile_path)

    pickers.new(opts, {
        prompt_title = "Makefile Targets",
        finder = finders.new_table {
            results = targets
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                run_make_command(selection[1])
            end)
            return true
        end,
    }):find()
end

vim.api.nvim_create_user_command("MakefileTargets", makefile_targets, {})
return require("telescope").register_extension({
    exports = {
        makefile_targets = makefile_targets
    },
})
