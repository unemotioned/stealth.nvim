local M = {}

function M.get(colors)
    return {
        OilEmpty = { fg = colors.comment },
        OilHidden = { fg = colors.comment },
        OilDir = { link = 'Directory' },
        OilDirHidden = { link = 'OilHidden' },
        OilDirIcon = { link = 'OilDir' },
        OilSocket = { fg = colors.indigo },
        OilSocketHidden = { link = 'OilHidden' },
        OilLink = { fg = colors.teal },
        OilOrphanLink = { fg = colors.diag_error },
        OilLinkHidden = { link = 'OilHidden' },
        OilOrphanLinkHidden = { link = 'OilOrphanLink' },
        OilLinkTarget = { fg = colors.fg_sub },
        OilOrphanLinkTarget = { fg = colors.diag_error },
        OilLinkTargetHidden = { link = 'OilHidden' },
        OilOrphanLinkTargetHidden = { link = 'OilOrphanLinkTarget' },
        OilFile = { fg = colors.fg },
        OilFileHidden = { link = 'OilHidden' },
        OilCreate = { fg = colors.git_add },
        OilDelete = { fg = colors.git_delete },
        OilMove = { fg = colors.git_dirty },
        OilCopy = { fg = colors.git_change },
        OilChange = { fg = colors.git_change },
        OilRestore = { link = 'OilCreate' },
        OilPurge = { link = 'OilDelete' },
        OilTrash = { link = 'OilDelete' },
        OilTrashSourcePath = { fg = colors.fg_sub },
    }
end

return M
