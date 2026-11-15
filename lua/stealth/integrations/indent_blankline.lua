local M = {}

function M.get(colors)
    return {
        IBLIndent = { fg = colors.fg_dim },
        IBLWhitespace = { fg = colors.fg_dim },
        IBLScope = { fg = colors.border_highlight },
        IndentBlanklineChar = { fg = colors.fg_dim },
        IndentBlanklineContextChar = { fg = colors.border_highlight },
    }
end

return M
