local M = {}

---Generate Lualine theme for Stealth
---@return table
function M.get()
    local colors = require('stealth.colors').setup()
    local inverse_fg = colors.bg == colors.none and colors.bg_base or colors.bg

    return {
        normal = {
            a = { fg = inverse_fg, bg = colors.accent },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        insert = {
            a = { fg = inverse_fg, bg = colors.green },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        visual = {
            a = { fg = inverse_fg, bg = colors.purple },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        replace = {
            a = { fg = inverse_fg, bg = colors.red },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        command = {
            a = { fg = inverse_fg, bg = colors.amber },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        inactive = {
            a = { fg = colors.fg_dim, bg = colors.bg_dark },
            b = { fg = colors.fg_dim, bg = colors.bg_dark },
            c = { fg = colors.fg_dim, bg = colors.bg_dark },
        },
    }
end

return M
