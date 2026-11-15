local completion = require('stealth.integrations.completion')

local M = {}

function M.get(colors, context)
    local highlights = {
        BlinkCmpLabel = { fg = colors.fg },
        BlinkCmpLabelDeprecated = { fg = colors.fg_sub, strikethrough = true },
        BlinkCmpLabelMatch = { fg = colors.accent },
        BlinkCmpLabelDetail = { fg = colors.fg_sub },
        BlinkCmpLabelDescription = { fg = colors.fg_sub },
        BlinkCmpSource = { fg = colors.fg_sub },
        BlinkCmpGhostText = { fg = colors.comment },
        BlinkCmpMenuBorder = { fg = colors.border_highlight, bg = colors.bg_popup },
        BlinkCmpDocBorder = { fg = colors.border_highlight, bg = context.float_bg },
        BlinkCmpSignatureHelpBorder = { fg = colors.border_highlight, bg = context.float_bg },
    }

    for kind, color in pairs(completion.kinds(colors)) do
        highlights['BlinkCmpKind' .. kind] = { fg = color }
    end

    return highlights
end

return M
