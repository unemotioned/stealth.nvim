local M = {}

---Generate highlight groups map
---@param colors table
---@param config StealthConfig
---@return table<string, table>
function M.setup(colors, config)
    config = config or require('stealth.config').options
    local styles = config.styles or {}

    local comment_style = styles.comments or { italic = true }
    local keyword_style = styles.keywords or { bold = true }
    local function_style = styles.functions or {}
    local variable_style = styles.variables or {}
    local parameter_style = styles.parameters or { italic = true }
    local string_style = styles.strings or {}
    local constant_style = styles.constants or { bold = true }
    local type_style = styles.types or {}

    local hl = {
        -- ===================================================================
        -- Standard Vim UI Highlights
        -- ===================================================================
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalNC = config.dim_inactive and { fg = colors.fg_dark, bg = colors.bg_dark }
            or { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = config.styles.floats == 'transparent' and colors.none or colors.bg_float },
        FloatBorder = {
            fg = colors.border_highlight,
            bg = config.styles.floats == 'transparent' and colors.none or colors.bg_float,
        },
        FloatTitle = { fg = colors.accent, bg = colors.bg_float, bold = true },
        FloatFooter = { fg = colors.fg_sub, bg = colors.bg_float },

        ColorColumn = { bg = colors.bg_line },
        Conceal = { fg = colors.fg_sub },
        Cursor = { fg = colors.bg, bg = colors.main },
        lCursor = { fg = colors.bg, bg = colors.main },
        CursorIM = { fg = colors.bg, bg = colors.main },
        CursorColumn = { bg = colors.bg_line },
        CursorLine = { bg = colors.bg_line },
        Directory = { fg = colors.cyan, bold = true },
        DiffAdd = { bg = '#142e23' },
        DiffChange = { bg = '#16273b' },
        DiffDelete = { bg = '#3b171f' },
        DiffText = { bg = '#25476d' },
        EndOfBuffer = { fg = colors.bg },
        ErrorMsg = { fg = colors.red, bold = true },
        WinSeparator = { fg = colors.win_separator },
        VertSplit = { fg = colors.win_separator },
        Folded = { fg = colors.fg_sub, bg = colors.bg_highlight },
        FoldColumn = { fg = colors.fg_gutter, bg = colors.bg },
        SignColumn = { fg = colors.fg_gutter, bg = colors.bg },
        IncSearch = { fg = colors.bg, bg = colors.amber, bold = true },
        CurSearch = { fg = colors.bg, bg = colors.amber, bold = true },
        Search = { fg = colors.fg, bg = colors.bg_search },
        Substitute = { fg = colors.bg, bg = colors.red, bold = true },
        LineNr = { fg = colors.fg_gutter },
        CursorLineNr = { fg = colors.fg, bold = true },
        MatchParen = { fg = colors.orange, bg = colors.bg_visual, bold = true },
        ModeMsg = { fg = colors.fg, bold = true },
        MsgArea = { fg = colors.fg },
        MoreMsg = { fg = colors.cyan },
        NonText = { fg = colors.fg_gutter },
        Pmenu = { fg = colors.fg, bg = colors.bg_popup },
        PmenuSel = { fg = colors.main, bg = colors.bg_visual, bold = true },
        PmenuSbar = { bg = colors.bg_highlight },
        PmenuThumb = { bg = colors.border_highlight },
        Question = { fg = colors.cyan },
        QuickFixLine = { bg = colors.bg_visual, bold = true },
        SpecialKey = { fg = colors.fg_gutter },
        SpellBad = { sp = colors.red, undercurl = true },
        SpellCap = { sp = colors.amber, undercurl = true },
        SpellLocal = { sp = colors.cyan, undercurl = true },
        SpellRare = { sp = colors.purple, undercurl = true },
        StatusLine = { fg = colors.fg, bg = colors.bg_dark },
        StatusLineNC = { fg = colors.fg_sub, bg = colors.bg_dark },
        TabLine = { fg = colors.fg_sub, bg = colors.bg_dark },
        TabLineFill = { bg = colors.bg_dark },
        TabLineSel = { fg = colors.main, bg = colors.bg, bold = true },
        Title = { fg = colors.accent, bold = true },
        Visual = { bg = colors.bg_visual },
        VisualNOS = { bg = colors.bg_visual },
        WarningMsg = { fg = colors.amber, bold = true },
        Whitespace = { fg = colors.fg_dim },
        WildMenu = { fg = colors.bg, bg = colors.cyan, bold = true },

        -- ===================================================================
        -- Standard Syntax Highlights (Personalized & Monkeytype Styled)
        -- ===================================================================
        Comment = vim.tbl_extend('force', { fg = colors.comment }, comment_style),
        Constant = vim.tbl_extend('force', { fg = colors.cyan }, constant_style),
        String = vim.tbl_extend('force', { fg = colors.green }, string_style),
        Character = { fg = colors.teal },
        Number = { fg = colors.orange },
        Boolean = { fg = colors.orange, bold = true },
        Float = { fg = colors.orange },

        Identifier = vim.tbl_extend('force', { fg = colors.fg }, variable_style),
        Function = vim.tbl_extend('force', { fg = colors.green }, function_style),

        Statement = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        Conditional = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Repeat = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Label = { fg = colors.cyan },
        Operator = { fg = colors.blue },
        Keyword = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        Exception = { fg = colors.red, bold = true },

        PreProc = { fg = colors.cyan },
        Include = { fg = colors.purple, bold = true },
        Define = { fg = colors.purple },
        Macro = { fg = colors.cyan },
        PreCondit = { fg = colors.purple },

        Type = vim.tbl_extend('force', { fg = colors.purple }, type_style),
        StorageClass = { fg = colors.blue },
        Structure = { fg = colors.purple },
        Typedef = { fg = colors.purple },

        Special = { fg = colors.teal },
        SpecialChar = { fg = colors.teal },
        Tag = { fg = colors.cyan },
        Delimiter = { fg = colors.fg_sub },
        SpecialComment = vim.tbl_extend('force', { fg = colors.cyan }, comment_style),
        Debug = { fg = colors.orange },

        Underlined = { underline = true },
        Ignore = { fg = colors.fg_dim },
        Error = { fg = colors.red, bold = true },
        Todo = { fg = colors.bg, bg = colors.amber, bold = true },

        -- ===================================================================
        -- Treesitter Highlights
        -- ===================================================================
        ['@comment'] = vim.tbl_extend('force', { fg = colors.comment }, comment_style),
        ['@comment.documentation'] = vim.tbl_extend('force', { fg = colors.comment, bold = true }, comment_style),
        ['@comment.note'] = { fg = colors.bg, bg = colors.cyan, bold = true },
        ['@comment.todo'] = { fg = colors.bg, bg = colors.amber, bold = true },
        ['@comment.warning'] = { fg = colors.bg, bg = colors.amber, bold = true },
        ['@comment.error'] = { fg = colors.bg, bg = colors.red, bold = true },

        ['@keyword'] = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        ['@keyword.function'] = vim.tbl_extend('force', { fg = colors.blue }, keyword_style),
        ['@keyword.operator'] = { fg = colors.blue },
        ['@keyword.return'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.conditional'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.repeat'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.import'] = { fg = colors.purple, bold = true },
        ['@keyword.directive'] = { fg = colors.cyan },

        ['@function'] = vim.tbl_extend('force', { fg = colors.green }, function_style),
        ['@function.builtin'] = vim.tbl_extend('force', { fg = colors.teal }, function_style),
        ['@function.macro'] = { fg = colors.cyan },
        ['@function.method'] = vim.tbl_extend('force', { fg = colors.green }, function_style),
        ['@method'] = vim.tbl_extend('force', { fg = colors.green }, function_style),

        ['@variable'] = vim.tbl_extend('force', { fg = colors.fg }, variable_style),
        ['@variable.builtin'] = vim.tbl_extend('force', { fg = colors.cyan }, variable_style),
        ['@variable.parameter'] = vim.tbl_extend('force', { fg = colors.fg_dark }, parameter_style),
        ['@variable.member'] = { fg = colors.fg },
        ['@property'] = { fg = colors.fg_dark },
        ['@field'] = { fg = colors.fg_dark },

        ['@constant'] = vim.tbl_extend('force', { fg = colors.cyan }, constant_style),
        ['@constant.builtin'] = vim.tbl_extend('force', { fg = colors.orange }, constant_style),
        ['@constant.macro'] = { fg = colors.cyan },

        ['@string'] = vim.tbl_extend('force', { fg = colors.green }, string_style),
        ['@string.regex'] = { fg = colors.teal },
        ['@string.escape'] = { fg = colors.teal, bold = true },
        ['@character'] = { fg = colors.teal },
        ['@number'] = { fg = colors.orange },
        ['@boolean'] = { fg = colors.orange, bold = true },
        ['@float'] = { fg = colors.orange },

        ['@type'] = vim.tbl_extend('force', { fg = colors.purple }, type_style),
        ['@type.builtin'] = vim.tbl_extend('force', { fg = colors.cyan }, type_style),
        ['@type.definition'] = vim.tbl_extend('force', { fg = colors.purple }, type_style),
        ['@type.qualifier'] = { fg = colors.indigo },

        ['@attribute'] = { fg = colors.cyan },
        ['@punctuation.delimiter'] = { fg = colors.fg_sub },
        ['@punctuation.bracket'] = { fg = colors.fg_sub },
        ['@punctuation.special'] = { fg = colors.teal },
        ['@operator'] = { fg = colors.blue },

        ['@tag'] = { fg = colors.purple },
        ['@tag.attribute'] = { fg = colors.cyan },
        ['@tag.delimiter'] = { fg = colors.fg_sub },

        ['@markup.heading'] = { fg = colors.accent, bold = true },
        ['@markup.raw'] = { fg = colors.green },
        ['@markup.italic'] = { italic = true },
        ['@markup.bold'] = { bold = true },
        ['@markup.list'] = { fg = colors.cyan },
        ['@markup.link'] = { fg = colors.cyan, underline = true },
        ['@markup.link.url'] = { fg = colors.fg_sub, underline = true },

        -- ===================================================================
        -- LSP Diagnostics & Semantic Tokens
        -- ===================================================================
        DiagnosticError = { fg = colors.diag_error },
        DiagnosticWarn = { fg = colors.diag_warn },
        DiagnosticInfo = { fg = colors.diag_info },
        DiagnosticHint = { fg = colors.diag_hint },

        DiagnosticUnderlineError = { sp = colors.diag_error, undercurl = true },
        DiagnosticUnderlineWarn = { sp = colors.diag_warn, undercurl = true },
        DiagnosticUnderlineInfo = { sp = colors.diag_info, undercurl = true },
        DiagnosticUnderlineHint = { sp = colors.diag_hint, undercurl = true },

        DiagnosticVirtualTextError = { fg = colors.diag_error, bg = '#29151c' },
        DiagnosticVirtualTextWarn = { fg = colors.diag_warn, bg = '#292115' },
        DiagnosticVirtualTextInfo = { fg = colors.diag_info, bg = '#152329' },
        DiagnosticVirtualTextHint = { fg = colors.diag_hint, bg = '#152922' },

        -- Preserve syntax foregrounds when highlighting the symbol under the cursor.
        LspReferenceText = { bg = colors.bg_visual },
        LspReferenceRead = { bg = colors.bg_visual },
        LspReferenceWrite = { bg = colors.bg_visual },
        LspReferenceTarget = { bg = colors.bg_visual },
        LspCodeLens = { fg = colors.fg_sub },
        LspSignatureActiveParameter = { fg = colors.accent, bold = true, underline = true },

        -- Semantic Tokens
        ['@lsp.type.class'] = { link = '@type' },
        ['@lsp.type.comment'] = { link = '@comment' },
        ['@lsp.type.enum'] = { link = '@type' },
        ['@lsp.type.enumMember'] = { link = '@constant' },
        ['@lsp.type.function'] = { link = '@function' },
        ['@lsp.type.interface'] = { link = '@type' },
        ['@lsp.type.keyword'] = { link = '@keyword' },
        ['@lsp.type.method'] = { link = '@function.method' },
        ['@lsp.type.namespace'] = { link = '@type' },
        ['@lsp.type.number'] = { link = '@number' },
        ['@lsp.type.operator'] = { link = '@operator' },
        ['@lsp.type.parameter'] = { link = '@variable.parameter' },
        ['@lsp.type.property'] = { link = '@property' },
        ['@lsp.type.string'] = { link = '@string' },
        ['@lsp.type.struct'] = { link = '@type' },
        ['@lsp.type.type'] = { link = '@type' },
        ['@lsp.type.variable'] = { link = '@variable' },

        -- ===================================================================
        -- Popular Plugins Support
        -- ===================================================================

        -- Telescope.nvim
        TelescopeNormal = { fg = colors.fg, bg = colors.bg_float },
        TelescopeBorder = { fg = colors.border_highlight, bg = colors.bg_float },
        TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_highlight },
        TelescopePromptBorder = { fg = colors.border_highlight, bg = colors.bg_highlight },
        TelescopePromptTitle = { fg = colors.bg, bg = colors.accent, bold = true },
        TelescopePreviewTitle = { fg = colors.bg, bg = colors.green, bold = true },
        TelescopeResultsTitle = { fg = colors.bg, bg = colors.cyan, bold = true },
        TelescopeSelection = { fg = colors.main, bg = colors.bg_visual, bold = true },
        TelescopeSelectionCaret = { fg = colors.accent, bold = true },
        TelescopeMatching = { fg = colors.amber, bold = true },

        -- NvimTree / NeoTree
        NvimTreeNormal = {
            fg = colors.fg,
            bg = config.styles.sidebars == 'transparent' and colors.none or colors.bg_sidebar,
        },
        NvimTreeNormalNC = {
            fg = colors.fg,
            bg = config.styles.sidebars == 'transparent' and colors.none or colors.bg_sidebar,
        },
        NvimTreeRootFolder = { fg = colors.accent, bold = true },
        NvimTreeFolderIcon = { fg = colors.cyan },
        NvimTreeFolderName = { fg = colors.fg },
        NvimTreeOpenedFolderName = { fg = colors.cyan, bold = true },
        NvimTreeEmptyFolderName = { fg = colors.fg_sub },
        NvimTreeGitDirty = { fg = colors.git_dirty },
        NvimTreeGitNew = { fg = colors.git_add },
        NvimTreeGitDeleted = { fg = colors.git_delete },

        NeoTreeNormal = {
            fg = colors.fg,
            bg = config.styles.sidebars == 'transparent' and colors.none or colors.bg_sidebar,
        },
        NeoTreeNormalNC = {
            fg = colors.fg,
            bg = config.styles.sidebars == 'transparent' and colors.none or colors.bg_sidebar,
        },
        NeoTreeRootName = { fg = colors.accent, bold = true },
        NeoTreeDirectoryName = { fg = colors.fg },
        NeoTreeDirectoryIcon = { fg = colors.cyan },
        NeoTreeGitAdded = { fg = colors.git_add },
        NeoTreeGitModified = { fg = colors.git_dirty },
        NeoTreeGitDeleted = { fg = colors.git_delete },

        -- WhichKey
        WhichKey = { fg = colors.cyan, bold = true },
        WhichKeyGroup = { fg = colors.purple, bold = true },
        WhichKeyDesc = { fg = colors.fg },
        WhichKeyIcon = { fg = colors.green },
        WhichKeyBorder = { fg = colors.border_highlight, bg = colors.bg_float },
        WhichKeyNormal = { bg = colors.bg_float },

        -- Gitsigns
        GitSignsAdd = { fg = colors.git_add },
        GitSignsChange = { fg = colors.git_change },
        GitSignsDelete = { fg = colors.git_delete },
        GitSignsCurrentLineBlame = { fg = colors.fg_sub, italic = true },

        -- Nvim-Cmp / Blink.cmp
        CmpItemAbbr = { fg = colors.fg },
        CmpItemAbbrDeprecated = { fg = colors.fg_sub, strikethrough = true },
        CmpItemAbbrMatch = { fg = colors.accent, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = colors.accent, bold = true },
        CmpItemKindFunction = { fg = colors.green },
        CmpItemKindMethod = { fg = colors.green },
        CmpItemKindVariable = { fg = colors.cyan },
        CmpItemKindKeyword = { fg = colors.indigo },
        CmpItemKindText = { fg = colors.fg_sub },

        BlinkCmpLabel = { fg = colors.fg },
        BlinkCmpLabelMatch = { fg = colors.accent, bold = true },
        BlinkCmpKindFunction = { fg = colors.green },
        BlinkCmpKindVariable = { fg = colors.cyan },
        BlinkCmpKindKeyword = { fg = colors.indigo },

        -- Indent Blankline
        IBLIndent = { fg = colors.fg_dim },
        IBLWhitespace = { fg = colors.fg_dim },
        IBLScope = { fg = colors.border_highlight },
        IndentBlanklineChar = { fg = colors.fg_dim },
        IndentBlanklineContextChar = { fg = colors.border_highlight },

        -- Trouble
        TroubleNormal = { fg = colors.fg, bg = colors.bg_float },
        TroubleText = { fg = colors.fg },
        TroubleCount = { fg = colors.purple, bold = true },
        TroubleSignError = { fg = colors.diag_error },
        TroubleSignWarning = { fg = colors.diag_warn },

        -- Dashboard / Alpha
        DashboardHeader = { fg = colors.accent, bold = true },
        DashboardCenter = { fg = colors.cyan },
        DashboardFooter = { fg = colors.fg_sub, italic = true },
        AlphaHeader = { fg = colors.accent, bold = true },
        AlphaButtons = { fg = colors.cyan },
        AlphaFooter = { fg = colors.fg_sub, italic = true },

        -- Noice / Notify
        NoiceCmdline = { fg = colors.fg },
        NoiceCmdlineIcon = { fg = colors.cyan },
        NoicePopup = { fg = colors.fg, bg = colors.bg_float },
        NotifyERRORBorder = { fg = colors.red },
        NotifyWARNBorder = { fg = colors.amber },
        NotifyINFOBorder = { fg = colors.cyan },
    }

    -- User custom highlights hook
    if type(config.on_highlights) == 'function' then
        config.on_highlights(hl, colors)
    end

    return hl
end

return M
