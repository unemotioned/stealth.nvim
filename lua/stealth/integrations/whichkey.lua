local M = {}

function M.get(colors, context)
    return {
        WhichKey = { fg = colors.cyan },
        WhichKeyGroup = { fg = colors.purple },
        WhichKeyDesc = { fg = colors.fg },
        WhichKeyIcon = { fg = colors.green },
        WhichKeyBorder = { fg = colors.border_highlight, bg = context.float_bg },
        WhichKeyNormal = { bg = context.float_bg },
    }
end

return M
