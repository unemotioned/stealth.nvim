local M = {}

function M.get(colors, context)
    local inverse_fg = context.inverse_fg
    local float_bg = context.float_bg

    return {
        MiniStatuslineModeNormal = { fg = inverse_fg, bg = colors.accent },
        MiniStatuslineModeInsert = { fg = inverse_fg, bg = colors.green },
        MiniStatuslineModeVisual = { fg = inverse_fg, bg = colors.purple },
        MiniStatuslineModeReplace = { fg = inverse_fg, bg = colors.red },
        MiniStatuslineModeCommand = { fg = inverse_fg, bg = colors.amber },
        MiniStatuslineModeOther = { fg = inverse_fg, bg = colors.cyan },
        MiniStatuslineDevinfo = { link = 'StatusLine' },
        MiniStatuslineFilename = { link = 'StatusLineNC' },
        MiniStatuslineFileinfo = { link = 'StatusLine' },
        MiniStatuslineInactive = { link = 'StatusLineNC' },

        MiniPickNormal = { link = 'NormalFloat' },
        MiniPickBorder = { link = 'FloatBorder' },
        MiniPickBorderBusy = { fg = colors.amber, bg = float_bg },
        MiniPickBorderText = { fg = colors.fg_sub, bg = float_bg },
        MiniPickCursor = { blend = 100, nocombine = true },
        MiniPickIconDirectory = { fg = colors.cyan },
        MiniPickIconFile = { fg = colors.fg_sub },
        MiniPickHeader = { fg = colors.accent },
        MiniPickMatchCurrent = { bg = colors.bg_visual },
        MiniPickMatchMarked = { fg = colors.amber },
        MiniPickMatchRanges = { fg = colors.amber },
        MiniPickPreviewLine = { bg = colors.bg_line },
        MiniPickPreviewRegion = { bg = colors.bg_visual },
        MiniPickPrompt = { fg = colors.fg },
        MiniPickPromptCaret = { fg = colors.accent },
        MiniPickPromptPrefix = { fg = colors.accent },

        MiniStarterCurrent = { fg = colors.main },
        MiniStarterFooter = { fg = colors.fg_sub },
        MiniStarterHeader = { fg = colors.accent },
        MiniStarterInactive = { fg = colors.comment },
        MiniStarterItem = { fg = colors.fg },
        MiniStarterItemBullet = { fg = colors.cyan },
        MiniStarterItemPrefix = { fg = colors.amber },
        MiniStarterSection = { fg = colors.cyan },
        MiniStarterQuery = { fg = colors.green },

        MiniFilesBorder = { link = 'FloatBorder' },
        MiniFilesBorderModified = { fg = colors.diag_warn, bg = float_bg },
        MiniFilesCursorLine = { link = 'CursorLine' },
        MiniFilesDirectory = { link = 'Directory' },
        MiniFilesFile = { fg = colors.fg },
        MiniFilesNormal = { link = 'NormalFloat' },
        MiniFilesTitle = { link = 'FloatTitle' },
        MiniFilesTitleFocused = { fg = colors.accent, bg = float_bg },
    }
end

return M
