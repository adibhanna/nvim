local M = {}

M.telescope_git_or_file = function()
  local path = vim.fn.expand("%:p:h")
  local git_dir = vim.fn.finddir(".git", path .. ";")
  if #git_dir > 0 then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

M.jumpable = function(dir)
  local luasnip_ok, luasnip = pcall(require, "luasnip")
  if not luasnip_ok then
    return false
  end

  local win_get_cursor = vim.api.nvim_win_get_cursor
  local get_current_buf = vim.api.nvim_get_current_buf

  ---sets the current buffer's luasnip to the one nearest the cursor
  ---@return boolean true if a node is found, false otherwise
  local function seek_luasnip_cursor_node()
    -- TODO(kylo252): upstream this
    -- for outdated versions of luasnip
    if not luasnip.session.current_nodes then
      return false
    end

    local node = luasnip.session.current_nodes[get_current_buf()]
    if not node then
      return false
    end

    local snippet = node.parent.snippet
    local exit_node = snippet.insert_nodes[0]

    local pos = win_get_cursor(0)
    pos[1] = pos[1] - 1

    -- exit early if we're past the exit node
    if exit_node then
      local exit_pos_end = exit_node.mark:pos_end()
      if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    node = snippet.inner_first:jump_into(1, true)
    while node ~= nil and node.next ~= nil and node ~= snippet do
      local n_next = node.next
      local next_pos = n_next and n_next.mark:pos_begin()
      local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
          or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

      -- Past unmarked exit node, exit early
      if n_next == nil or n_next == snippet.next then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end

      if candidate then
        luasnip.session.current_nodes[get_current_buf()] = node
        return true
      end

      local ok
      ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
      if not ok then
        snippet:remove_from_jumplist()
        luasnip.session.current_nodes[get_current_buf()] = nil

        return false
      end
    end

    -- No candidate, but have an exit node
    if exit_node then
      -- to jump to the exit node, seek to snippet
      luasnip.session.current_nodes[get_current_buf()] = snippet
      return true
    end

    -- No exit node, exit from snippet
    snippet:remove_from_jumplist()
    luasnip.session.current_nodes[get_current_buf()] = nil
    return false
  end

  if dir == -1 then
    return luasnip.in_snippet() and luasnip.jumpable(-1)
  else
    return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
  end
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

M.toggle_inlay_hints = function()
  -- h = { "<cmd>lua vim.lsp.inlay_hint(0, true)<cr>", "Enable Inlay Hints" },
  -- H = { "<cmd>lua vim.lsp.inlay_hint(0, false)<cr>", "Disable Inlay Hints" },

  if vim.b.inlay_hints then
    vim.lsp.inlay_hint(0, false)
    vim.b.inlay_hints = false
  else
    vim.lsp.inlay_hint(0, true)
    vim.b.inlay_hints = true
  end
end

M.toggle_set_color_column = function()
  if vim.wo.colorcolumn == "" then
    vim.wo.colorcolumn = "80"
  else
    vim.wo.colorcolumn = ""
  end
end

M.toggle_cursor_line = function()
  if vim.wo.cursorline then
    vim.wo.cursorline = false
  else
    vim.wo.cursorline = true
  end
end

M.change_background = function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end


M.toggle_go_test = function()
  -- Get the current buffer's file name
  local current_file = vim.fn.expand('%:p')
  if string.match(current_file, '_test.go$') then
    -- If the current file ends with '_test.go', try to find the corresponding non-test file
    local non_test_file = string.gsub(current_file, '_test.go$', '.go')
    if vim.fn.filereadable(non_test_file) == 1 then
      -- Open the corresponding non-test file if it exists
      vim.cmd.edit(non_test_file)
    else
      print('No corresponding non-test file found')
    end
  else
    -- If the current file is a non-test file, try to find the corresponding test file
    local test_file = string.gsub(current_file, '.go$', '_test.go')
    if vim.fn.filereadable(test_file) == 1 then
      -- Open the corresponding test file if it exists
      vim.cmd.edit(test_file)
    else
      print('No corresponding test file found')
    end
  end
end


M.declutter_terminal = function()
  require('lualine').hide()
  vim.cmd('silent !tmux set-option -g status off')
end

M.clutter_terminal = function()
  require('lualine').hide({ unhide = true })
  vim.cmd('silent !tmux set-option -g status on')
end

-- Copy the current file path and line number to the clipboard, use GitHub URL if in a Git repository
M.copyFilePathAndLineNumber = function()
  local current_file = vim.fn.expand('%:p')
  local current_line = vim.fn.line('.')
  local is_git_repo = vim.fn.system('git rev-parse --is-inside-work-tree'):match('true')

  if is_git_repo then
    local current_repo = vim.fn.systemlist('git remote get-url origin')[1]
    local current_branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]

    -- Convert Git URL to GitHub web URL format
    current_repo = current_repo:gsub("git@github.com:", "https://github.com/")
    current_repo = current_repo:gsub("%.git$", "")

    -- Remove leading system path to repository root
    local repo_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
    if repo_root then
      current_file = current_file:sub(#repo_root + 2)
    end

    local url = string.format('%s/blob/%s/%s#L%s', current_repo, current_branch, current_file, current_line)
    vim.fn.setreg('+', url)
    print('Copied to clipboard: ' .. url)
  else
    -- If not in a Git directory, copy the full file path
    vim.fn.setreg('+', current_file .. '#L' .. current_line)
    print('Copied full path to clipboard: ' .. current_file .. '#L' .. current_line)
  end
end

return M
