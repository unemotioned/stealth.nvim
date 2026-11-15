local M = {}

function M.get(colors, context)
    return {
        NeoTreeNormal = { fg = colors.fg, bg = context.sidebar_bg },
        NeoTreeNormalNC = { fg = colors.fg, bg = context.sidebar_bg },
        NeoTreeRootName = { fg = colors.accent },
        NeoTreeDirectoryName = { fg = colors.fg },
        NeoTreeDirectoryIcon = { fg = colors.cyan },
        NeoTreeGitAdded = { fg = colors.git_add },
        NeoTreeGitModified = { fg = colors.git_dirty },
        NeoTreeGitDeleted = { fg = colors.git_delete },
    }
end

return M
