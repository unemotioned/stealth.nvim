local M = {}

function M.get(colors, context)
    return {
        TroubleNormal = { fg = colors.fg, bg = context.float_bg },
        TroubleText = { fg = colors.fg },
        TroubleCount = { fg = colors.purple },
        TroubleSignError = { fg = colors.diag_error },
        TroubleSignWarning = { fg = colors.diag_warn },
    }
end

return M
