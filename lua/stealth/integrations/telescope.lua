local M = {}

function M.get(colors, context)
    return {
        TelescopeNormal = { fg = colors.fg, bg = context.float_bg },
        TelescopeBorder = { fg = colors.border_highlight, bg = context.float_bg },
        TelescopePromptNormal = { fg = colors.fg, bg = context.prompt_bg },
        TelescopePromptBorder = { fg = colors.border_highlight, bg = context.prompt_bg },
        TelescopePromptTitle = { fg = context.inverse_fg, bg = colors.accent },
        TelescopePreviewTitle = { fg = context.inverse_fg, bg = colors.green },
        TelescopeResultsTitle = { fg = context.inverse_fg, bg = colors.cyan },
        TelescopeSelection = { fg = colors.main, bg = colors.bg_visual },
        TelescopeSelectionCaret = { fg = colors.accent },
        TelescopeMatching = { fg = colors.amber },
    }
end

return M
