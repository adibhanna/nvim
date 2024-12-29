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
  -- Define the buffer name
  local buf_name = "Make Output: " .. target
  -- Check if the buffer already exists and delete it
  for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf_id) and vim.api.nvim_buf_get_name(buf_id):match(vim.pesc(buf_name)) then
      vim.api.nvim_buf_delete(buf_id, { force = true })
    end
  end
  -- Open a split at the bottom
  vim.cmd("botright new")
  local buf = vim.api.nvim_get_current_buf()
  -- Rename the new buffer to avoid overwriting the previous buffer
  vim.api.nvim_buf_set_name(buf, buf_name)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  -- Set the buffer to be deleted on quit
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    callback = function()
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end,
  })
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
    attach_mappings = function(prompt_bufnr, _)
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
