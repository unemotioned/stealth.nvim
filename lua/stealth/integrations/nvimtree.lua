local M = {}

function M.get(colors, context)
    return {
        NvimTreeNormal = { fg = colors.fg, bg = context.sidebar_bg },
        NvimTreeNormalNC = { fg = colors.fg, bg = context.sidebar_bg },
        NvimTreeRootFolder = { fg = colors.accent },
        NvimTreeFolderIcon = { fg = colors.cyan },
        NvimTreeFolderName = { fg = colors.fg },
        NvimTreeOpenedFolderName = { fg = colors.cyan },
        NvimTreeEmptyFolderName = { fg = colors.fg_sub },
        NvimTreeGitDirty = { fg = colors.git_dirty },
        NvimTreeGitNew = { fg = colors.git_add },
        NvimTreeGitDeleted = { fg = colors.git_delete },
    }
end

return M
