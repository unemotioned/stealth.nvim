local M = {}

function M.get(colors)
    return {
        DashboardHeader = { fg = colors.accent },
        DashboardCenter = { fg = colors.cyan },
        DashboardFooter = { fg = colors.fg_sub },
    }
end

return M
