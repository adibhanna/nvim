local M = {}

M.telescope_git_or_file = function()
    -- if the directory is a git repo, open telescope git files
    -- otherwise open telescope find files
    -- the goal is to be able to use <leader>f for both

    local path = vim.fn.expand("%:p:h")
    local git_dir = vim.fn.finddir(".git", path .. ";")
    if #git_dir > 0 then
        require("telescope.builtin").git_files()
    else
        require("telescope.builtin").find_files()
    end
end

return M
