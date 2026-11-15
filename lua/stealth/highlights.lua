local integrations = require('stealth.integrations')

local M = {}

---Generate highlight groups map
---@param colors table
---@param config StealthConfig
---@return table<string, table>
function M.setup(colors, config)
    config = config or require('stealth.config').options
    local styles = config.styles or {}

    local comment_style = styles.comments or {}
    local keyword_style = styles.keywords or {}
    local function_style = styles.functions or {}
    local variable_style = styles.variables or {}
    local string_style = styles.strings or {}
    local constant_style = styles.constants or {}
    local type_style = styles.types or {}
    local inverse_fg = colors.bg == colors.none and colors.bg_base or colors.bg

    local function window_bg(style, dark_bg)
        if style == 'transparent' or ((style == nil or style == 'auto') and config.transparent) then
            return colors.none
        end
        return style == 'normal' and colors.bg or dark_bg
    end

    local float_bg = window_bg(styles.floats, colors.bg_float)
    local sidebar_bg = window_bg(styles.sidebars, colors.bg_sidebar)
    local prompt_bg = (float_bg == colors.none or styles.floats == 'normal') and float_bg or colors.bg_highlight

    local hl = {
        -- ===================================================================
        -- Standard Vim UI Highlights
        -- ===================================================================
        Normal = { fg = colors.fg, bg = colors.bg },
        NormalNC = config.dim_inactive and { fg = colors.fg_dark, bg = colors.bg_dark }
            or { fg = colors.fg, bg = colors.bg },
        NormalFloat = { fg = colors.fg, bg = float_bg },
        FloatBorder = {
            fg = colors.border_highlight,
            bg = float_bg,
        },
        FloatTitle = { fg = colors.accent, bg = float_bg },
        FloatFooter = { fg = colors.fg_sub, bg = float_bg },

        ColorColumn = { bg = colors.bg_line },
        Conceal = { fg = colors.fg_sub },
        Cursor = { fg = inverse_fg, bg = colors.main },
        lCursor = { fg = inverse_fg, bg = colors.main },
        CursorIM = { fg = inverse_fg, bg = colors.main },
        CursorColumn = { bg = colors.bg_line },
        CursorLine = { bg = colors.bg_line },
        Directory = { fg = colors.cyan },
        DiffAdd = { bg = colors.diff_add },
        DiffChange = { bg = colors.diff_change },
        DiffDelete = { bg = colors.diff_delete },
        DiffText = { bg = colors.diff_text },
        EndOfBuffer = { fg = inverse_fg },
        ErrorMsg = { fg = colors.red },
        WinSeparator = { fg = colors.win_separator },
        VertSplit = { fg = colors.win_separator },
        Folded = { fg = colors.fg_sub, bg = colors.bg_highlight },
        FoldColumn = { fg = colors.fg_gutter, bg = colors.bg },
        SignColumn = { fg = colors.fg_gutter, bg = colors.bg },
        IncSearch = { fg = inverse_fg, bg = colors.amber },
        CurSearch = { fg = inverse_fg, bg = colors.amber },
        Search = { fg = colors.fg, bg = colors.bg_search },
        Substitute = { fg = inverse_fg, bg = colors.red },
        LineNr = { fg = colors.fg_gutter },
        CursorLineNr = { fg = colors.fg },
        MatchParen = { fg = colors.orange, bg = colors.bg_visual },
        ModeMsg = { fg = colors.fg },
        MsgArea = { fg = colors.fg },
        MoreMsg = { fg = colors.cyan },
        NonText = { fg = colors.fg_gutter },
        Pmenu = { fg = colors.fg, bg = colors.bg_popup },
        PmenuSel = { fg = colors.main, bg = colors.bg_visual },
        PmenuMatch = {},
        PmenuMatchSel = {},
        PmenuSbar = { bg = colors.bg_highlight },
        PmenuThumb = { bg = colors.border_highlight },
        Question = { fg = colors.cyan },
        QuickFixLine = { bg = colors.bg_visual },
        SpecialKey = { fg = colors.fg_gutter },
        SpellBad = { sp = colors.red, undercurl = true },
        SpellCap = { sp = colors.amber, undercurl = true },
        SpellLocal = { sp = colors.cyan, undercurl = true },
        SpellRare = { sp = colors.purple, undercurl = true },
        StatusLine = { fg = colors.fg, bg = colors.bg_dark },
        StatusLineNC = { fg = colors.fg_sub, bg = colors.bg_dark },
        TabLine = { fg = colors.fg_sub, bg = colors.bg_dark },
        TabLineFill = { bg = colors.bg_dark },
        TabLineSel = { fg = colors.main, bg = colors.bg },
        Title = { fg = colors.accent },
        Visual = { bg = colors.bg_visual },
        VisualNOS = { bg = colors.bg_visual },
        WarningMsg = { fg = colors.diag_warn },
        Whitespace = { fg = colors.fg_dim },
        WildMenu = { fg = inverse_fg, bg = colors.cyan },
        WinBar = { fg = colors.fg, bg = colors.bg_dark },
        WinBarNC = { fg = colors.fg_sub, bg = colors.bg_dark },

        -- ===================================================================
        -- Standard Syntax Highlights (Personalized & Monkeytype Styled)
        -- ===================================================================
        Comment = vim.tbl_extend('force', { fg = colors.comment }, comment_style),
        Constant = vim.tbl_extend('force', { fg = colors.cyan }, constant_style),
        String = vim.tbl_extend('force', { fg = colors.green }, string_style),
        Character = { fg = colors.teal },
        Number = { fg = colors.orange },
        Boolean = { fg = colors.orange },
        Float = { fg = colors.orange },

        Identifier = vim.tbl_extend('force', { fg = colors.fg }, variable_style),
        Function = vim.tbl_extend('force', { fg = colors.green }, function_style),

        Statement = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        Conditional = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Repeat = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Label = { fg = colors.cyan },
        Operator = { fg = colors.blue },
        Keyword = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        Exception = vim.tbl_extend('force', { fg = colors.red }, keyword_style),

        PreProc = { fg = colors.cyan },
        Include = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Define = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        Macro = { fg = colors.cyan },
        PreCondit = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),

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

        -- Vim's Markdown syntax links its emphasis groups to these HTML groups.
        StealthPlain = {},
        htmlBold = { link = 'StealthPlain' },
        htmlItalic = { link = 'StealthPlain' },
        htmlBoldItalic = { link = 'StealthPlain' },
        htmlBoldUnderline = { underline = true },
        htmlBoldUnderlineItalic = { underline = true },
        htmlUnderlineItalic = { underline = true },

        Underlined = { underline = true },
        Ignore = { fg = colors.fg_dim },
        Error = { fg = colors.red },
        Todo = { fg = inverse_fg, bg = colors.diag_warn },
        Added = { fg = colors.git_add },
        Changed = { fg = colors.git_change },
        Removed = { fg = colors.git_delete },
    }

    local context = {
        styles = styles,
        inverse_fg = inverse_fg,
        float_bg = float_bg,
        sidebar_bg = sidebar_bg,
        prompt_bg = prompt_bg,
    }
    for group, definition in pairs(integrations.get(colors, config, context)) do
        hl[group] = definition
    end

    -- User custom highlights hook
    if type(config.on_highlights) == 'function' then
        config.on_highlights(hl, colors)
    end

    return hl
end

return M
