local M = {}

function M.get(colors)
    return {
        DiagnosticError = { fg = colors.diag_error },
        DiagnosticWarn = { fg = colors.diag_warn },
        DiagnosticInfo = { fg = colors.diag_info },
        DiagnosticHint = { fg = colors.diag_hint },
        DiagnosticOk = { fg = colors.diag_ok },

        DiagnosticUnderlineError = { sp = colors.diag_error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.diag_warn, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.diag_info, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.diag_hint, undercurl = true },
        DiagnosticUnderlineOk = { sp = colors.diag_ok, undercurl = true },

        DiagnosticVirtualTextError = { fg = colors.diag_error, bg = colors.diag_bg_error },
        DiagnosticVirtualTextWarn = { fg = colors.diag_warn, bg = colors.diag_bg_warn },
        DiagnosticVirtualTextInfo = { fg = colors.diag_info, bg = colors.diag_bg_info },
        DiagnosticVirtualTextHint = { fg = colors.diag_hint, bg = colors.diag_bg_hint },
        DiagnosticVirtualTextOk = { fg = colors.diag_ok, bg = colors.diag_bg_ok },

        -- Preserve syntax foregrounds when highlighting the symbol under the cursor.
        LspReferenceText = { bg = colors.bg_visual },
        LspReferenceRead = { bg = colors.bg_visual },
        LspReferenceWrite = { bg = colors.bg_visual },
        LspReferenceTarget = { bg = colors.bg_visual },
        LspCodeLens = { fg = colors.fg_sub },
        LspInlayHint = { fg = colors.comment },
        LspSignatureActiveParameter = { fg = colors.accent, underline = true },
    }
end

return M
