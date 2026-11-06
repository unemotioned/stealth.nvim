local M = {}

---Generate Lualine theme for Stealth
---@return table
function M.get()
    local colors = require('stealth.colors').setup()

    return {
        normal = {
            a = { fg = colors.bg, bg = colors.accent, bold = true },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        insert = {
            a = { fg = colors.bg, bg = colors.green, bold = true },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        visual = {
            a = { fg = colors.bg, bg = colors.purple, bold = true },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        replace = {
            a = { fg = colors.bg, bg = colors.red, bold = true },
            b = { fg = colors.fg, bg = colors.bg_highlight },
            c = { fg = colors.fg_sub, bg = colors.bg_dark },
        },
        command = {
            a = { fg = colors.bg, bg = colors.amber, bold = true },
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
