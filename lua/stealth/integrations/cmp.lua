local completion = require('stealth.integrations.completion')

local M = {}

function M.get(colors)
    local highlights = {
        CmpItemAbbr = { fg = colors.fg },
        CmpItemAbbrDeprecated = { fg = colors.fg_sub, strikethrough = true },
        CmpItemAbbrMatch = { fg = colors.accent },
        CmpItemAbbrMatchFuzzy = { fg = colors.accent },
        CmpItemMenu = { fg = colors.fg_sub },
        CmpItemKind = { fg = colors.fg_sub },
    }

    for kind, color in pairs(completion.kinds(colors)) do
        highlights['CmpItemKind' .. kind] = { fg = color }
    end

    return highlights
end

return M
