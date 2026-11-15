local M = {}

function M.get(colors)
    return {
        AlphaHeader = { fg = colors.accent },
        AlphaButtons = { fg = colors.cyan },
        AlphaFooter = { fg = colors.fg_sub },
    }
end

return M
