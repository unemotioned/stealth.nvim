local M = {}

function M.get(colors)
    return {
        GitSignsAdd = { fg = colors.git_add },
        GitSignsChange = { fg = colors.git_change },
        GitSignsDelete = { fg = colors.git_delete },
        GitSignsCurrentLineBlame = { fg = colors.fg_sub },
    }
end

return M
