vim.o.tabstop = 4

-- GoModernize command: runs gopls modernize analyzer on the current buffer
vim.api.nvim_buf_create_user_command(0, "GoModernize", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    if filepath == "" then
        vim.notify("Buffer has no file path", vim.log.levels.ERROR)
        return
    end

    -- Save the buffer first to ensure modernize works on the latest content
    vim.cmd("silent write")

    -- Run gopls modernize via go run
    local cmd = {
        "go", "run",
        "golang.org/x/tools/gopls/internal/analysis/modernize/cmd/modernize@latest",
        "-fix",
        filepath,
    }

    vim.notify("GoModernize: running...", vim.log.levels.INFO)

    vim.system(cmd, { text = true }, function(result)
        vim.schedule(function()
            if result.code == 0 then
                -- Reload the buffer to pick up changes
                vim.cmd("checktime")
                local msg = result.stderr or ""
                if msg ~= "" then
                    vim.notify("GoModernize: " .. msg, vim.log.levels.INFO)
                else
                    vim.notify("GoModernize: completed", vim.log.levels.INFO)
                end
            else
                local err = result.stderr or result.stdout or "Unknown error"
                vim.notify("GoModernize failed: " .. err, vim.log.levels.ERROR)
            end
        end)
    end)
end, { desc = "Run gopls modernize -fix on current buffer" })
