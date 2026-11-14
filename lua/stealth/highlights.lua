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
    local parameter_style = styles.parameters or {}
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

        -- ===================================================================
        -- Treesitter Highlights
        -- ===================================================================
        ['@comment'] = vim.tbl_extend('force', { fg = colors.comment }, comment_style),
        ['@comment.documentation'] = vim.tbl_extend('force', { fg = colors.comment }, comment_style),
        ['@comment.note'] = { fg = inverse_fg, bg = colors.cyan },
        ['@comment.todo'] = { fg = inverse_fg, bg = colors.diag_warn },
        ['@comment.warning'] = { fg = inverse_fg, bg = colors.diag_warn },
        ['@comment.error'] = { fg = inverse_fg, bg = colors.red },

        ['@keyword'] = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        ['@keyword.coroutine'] = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        ['@keyword.function'] = vim.tbl_extend('force', { fg = colors.blue }, keyword_style),
        ['@keyword.operator'] = vim.tbl_extend('force', { fg = colors.blue }, keyword_style),
        ['@keyword.return'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.conditional'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.conditional.ternary'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.repeat'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.import'] = vim.tbl_extend('force', { fg = colors.purple }, keyword_style),
        ['@keyword.type'] = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        ['@keyword.modifier'] = vim.tbl_extend('force', { fg = colors.indigo }, keyword_style),
        ['@keyword.debug'] = vim.tbl_extend('force', { fg = colors.orange }, keyword_style),
        ['@keyword.exception'] = vim.tbl_extend('force', { fg = colors.red }, keyword_style),
        ['@keyword.directive'] = vim.tbl_extend('force', { fg = colors.cyan }, keyword_style),
        ['@keyword.directive.define'] = vim.tbl_extend('force', { fg = colors.cyan }, keyword_style),

        ['@function'] = vim.tbl_extend('force', { fg = colors.green }, function_style),
        ['@function.builtin'] = vim.tbl_extend('force', { fg = colors.teal }, function_style),
        ['@function.macro'] = vim.tbl_extend('force', { fg = colors.cyan }, function_style),
        ['@function.method'] = vim.tbl_extend('force', { fg = colors.green }, function_style),
        ['@method'] = vim.tbl_extend('force', { fg = colors.green }, function_style),

        ['@variable'] = vim.tbl_extend('force', { fg = colors.fg }, variable_style),
        ['@variable.builtin'] = vim.tbl_extend('force', { fg = colors.cyan }, variable_style),
        ['@variable.parameter'] = vim.tbl_extend('force', { fg = colors.fg_dark }, parameter_style),
        ['@variable.member'] = vim.tbl_extend('force', { fg = colors.fg }, variable_style),
        ['@property'] = vim.tbl_extend('force', { fg = colors.fg_dark }, variable_style),
        ['@field'] = vim.tbl_extend('force', { fg = colors.fg_dark }, variable_style),

        ['@constant'] = vim.tbl_extend('force', { fg = colors.cyan }, constant_style),
        ['@constant.builtin'] = vim.tbl_extend('force', { fg = colors.orange }, constant_style),
        ['@constant.macro'] = vim.tbl_extend('force', { fg = colors.cyan }, constant_style),

        ['@string'] = vim.tbl_extend('force', { fg = colors.green }, string_style),
        ['@string.regexp'] = vim.tbl_extend('force', { fg = colors.teal }, string_style),
        ['@string.regex'] = { link = '@string.regexp' },
        ['@string.escape'] = vim.tbl_extend('force', { fg = colors.teal }, string_style),
        ['@character'] = { fg = colors.teal },
        ['@number'] = { fg = colors.orange },
        ['@boolean'] = { fg = colors.orange },
        ['@number.float'] = { fg = colors.orange },
        ['@float'] = { link = '@number.float' },

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

        ['@markup.heading'] = { fg = colors.accent },
        ['@markup.raw'] = { fg = colors.green },
        ['@markup.italic'] = {},
        ['@markup.strong'] = {},
        ['@markup.bold'] = { link = '@markup.strong' },
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
        ['@lsp.type.regexp'] = { link = '@string.regexp' },
        ['@lsp.type.string'] = { link = '@string' },
        ['@lsp.type.struct'] = { link = '@type' },
        ['@lsp.type.type'] = { link = '@type' },
        ['@lsp.type.variable'] = { link = '@variable' },

        -- ===================================================================
        -- Popular Plugins Support
        -- ===================================================================

        -- Telescope.nvim
        TelescopeNormal = { fg = colors.fg, bg = float_bg },
        TelescopeBorder = { fg = colors.border_highlight, bg = float_bg },
        TelescopePromptNormal = { fg = colors.fg, bg = prompt_bg },
        TelescopePromptBorder = { fg = colors.border_highlight, bg = prompt_bg },
        TelescopePromptTitle = { fg = inverse_fg, bg = colors.accent },
        TelescopePreviewTitle = { fg = inverse_fg, bg = colors.green },
        TelescopeResultsTitle = { fg = inverse_fg, bg = colors.cyan },
        TelescopeSelection = { fg = colors.main, bg = colors.bg_visual },
        TelescopeSelectionCaret = { fg = colors.accent },
        TelescopeMatching = { fg = colors.amber },

        -- NvimTree / NeoTree
        NvimTreeNormal = {
            fg = colors.fg,
            bg = sidebar_bg,
        },
        NvimTreeNormalNC = {
            fg = colors.fg,
            bg = sidebar_bg,
        },
        NvimTreeRootFolder = { fg = colors.accent },
        NvimTreeFolderIcon = { fg = colors.cyan },
        NvimTreeFolderName = { fg = colors.fg },
        NvimTreeOpenedFolderName = { fg = colors.cyan },
        NvimTreeEmptyFolderName = { fg = colors.fg_sub },
        NvimTreeGitDirty = { fg = colors.git_dirty },
        NvimTreeGitNew = { fg = colors.git_add },
        NvimTreeGitDeleted = { fg = colors.git_delete },

        NeoTreeNormal = {
            fg = colors.fg,
            bg = sidebar_bg,
        },
        NeoTreeNormalNC = {
            fg = colors.fg,
            bg = sidebar_bg,
        },
        NeoTreeRootName = { fg = colors.accent },
        NeoTreeDirectoryName = { fg = colors.fg },
        NeoTreeDirectoryIcon = { fg = colors.cyan },
        NeoTreeGitAdded = { fg = colors.git_add },
        NeoTreeGitModified = { fg = colors.git_dirty },
        NeoTreeGitDeleted = { fg = colors.git_delete },

        -- Oil.nvim
        OilEmpty = { fg = colors.comment },
        OilHidden = { fg = colors.comment },
        OilDir = { link = 'Directory' },
        OilDirHidden = { link = 'OilHidden' },
        OilDirIcon = { link = 'OilDir' },
        OilSocket = { fg = colors.indigo },
        OilSocketHidden = { link = 'OilHidden' },
        OilLink = { fg = colors.teal },
        OilOrphanLink = { fg = colors.diag_error },
        OilLinkHidden = { link = 'OilHidden' },
        OilOrphanLinkHidden = { link = 'OilOrphanLink' },
        OilLinkTarget = { fg = colors.fg_sub },
        OilOrphanLinkTarget = { fg = colors.diag_error },
        OilLinkTargetHidden = { link = 'OilHidden' },
        OilOrphanLinkTargetHidden = { link = 'OilOrphanLinkTarget' },
        OilFile = { fg = colors.fg },
        OilFileHidden = { link = 'OilHidden' },
        OilCreate = { fg = colors.git_add },
        OilDelete = { fg = colors.git_delete },
        OilMove = { fg = colors.git_dirty },
        OilCopy = { fg = colors.git_change },
        OilChange = { fg = colors.git_change },
        OilRestore = { link = 'OilCreate' },
        OilPurge = { link = 'OilDelete' },
        OilTrash = { link = 'OilDelete' },
        OilTrashSourcePath = { fg = colors.fg_sub },

        -- WhichKey
        WhichKey = { fg = colors.cyan },
        WhichKeyGroup = { fg = colors.purple },
        WhichKeyDesc = { fg = colors.fg },
        WhichKeyIcon = { fg = colors.green },
        WhichKeyBorder = { fg = colors.border_highlight, bg = float_bg },
        WhichKeyNormal = { bg = float_bg },

        -- Gitsigns
        GitSignsAdd = { fg = colors.git_add },
        GitSignsChange = { fg = colors.git_change },
        GitSignsDelete = { fg = colors.git_delete },
        GitSignsCurrentLineBlame = { fg = colors.fg_sub },

        -- Nvim-Cmp / Blink.cmp
        CmpItemAbbr = { fg = colors.fg },
        CmpItemAbbrDeprecated = { fg = colors.fg_sub, strikethrough = true },
        CmpItemAbbrMatch = { fg = colors.accent },
        CmpItemAbbrMatchFuzzy = { fg = colors.accent },
        CmpItemMenu = { fg = colors.fg_sub },
        CmpItemKind = { fg = colors.fg_sub },

        BlinkCmpLabel = { fg = colors.fg },
        BlinkCmpLabelDeprecated = { fg = colors.fg_sub, strikethrough = true },
        BlinkCmpLabelMatch = { fg = colors.accent },
        BlinkCmpLabelDetail = { fg = colors.fg_sub },
        BlinkCmpLabelDescription = { fg = colors.fg_sub },
        BlinkCmpSource = { fg = colors.fg_sub },
        BlinkCmpGhostText = { fg = colors.comment },
        BlinkCmpMenuBorder = { fg = colors.border_highlight, bg = colors.bg_popup },
        BlinkCmpDocBorder = { fg = colors.border_highlight, bg = float_bg },
        BlinkCmpSignatureHelpBorder = { fg = colors.border_highlight, bg = float_bg },

        -- Indent Blankline
        IBLIndent = { fg = colors.fg_dim },
        IBLWhitespace = { fg = colors.fg_dim },
        IBLScope = { fg = colors.border_highlight },
        IndentBlanklineChar = { fg = colors.fg_dim },
        IndentBlanklineContextChar = { fg = colors.border_highlight },

        -- Mini.nvim
        MiniStatuslineModeNormal = { fg = inverse_fg, bg = colors.accent },
        MiniStatuslineModeInsert = { fg = inverse_fg, bg = colors.green },
        MiniStatuslineModeVisual = { fg = inverse_fg, bg = colors.purple },
        MiniStatuslineModeReplace = { fg = inverse_fg, bg = colors.red },
        MiniStatuslineModeCommand = { fg = inverse_fg, bg = colors.amber },
        MiniStatuslineModeOther = { fg = inverse_fg, bg = colors.cyan },
        MiniStatuslineDevinfo = { link = 'StatusLine' },
        MiniStatuslineFilename = { link = 'StatusLineNC' },
        MiniStatuslineFileinfo = { link = 'StatusLine' },
        MiniStatuslineInactive = { link = 'StatusLineNC' },

        MiniPickNormal = { link = 'NormalFloat' },
        MiniPickBorder = { link = 'FloatBorder' },
        MiniPickBorderBusy = { fg = colors.amber, bg = float_bg },
        MiniPickBorderText = { fg = colors.fg_sub, bg = float_bg },
        MiniPickCursor = { blend = 100, nocombine = true },
        MiniPickIconDirectory = { fg = colors.cyan },
        MiniPickIconFile = { fg = colors.fg_sub },
        MiniPickHeader = { fg = colors.accent },
        MiniPickMatchCurrent = { bg = colors.bg_visual },
        MiniPickMatchMarked = { fg = colors.amber },
        MiniPickMatchRanges = { fg = colors.amber },
        MiniPickPreviewLine = { bg = colors.bg_line },
        MiniPickPreviewRegion = { bg = colors.bg_visual },
        MiniPickPrompt = { fg = colors.fg },
        MiniPickPromptCaret = { fg = colors.accent },
        MiniPickPromptPrefix = { fg = colors.accent },

        MiniStarterCurrent = { fg = colors.main },
        MiniStarterFooter = { fg = colors.fg_sub },
        MiniStarterHeader = { fg = colors.accent },
        MiniStarterInactive = { fg = colors.comment },
        MiniStarterItem = { fg = colors.fg },
        MiniStarterItemBullet = { fg = colors.cyan },
        MiniStarterItemPrefix = { fg = colors.amber },
        MiniStarterSection = { fg = colors.cyan },
        MiniStarterQuery = { fg = colors.green },

        MiniFilesBorder = { link = 'FloatBorder' },
        MiniFilesBorderModified = { fg = colors.diag_warn, bg = float_bg },
        MiniFilesCursorLine = { link = 'CursorLine' },
        MiniFilesDirectory = { link = 'Directory' },
        MiniFilesFile = { fg = colors.fg },
        MiniFilesNormal = { link = 'NormalFloat' },
        MiniFilesTitle = { link = 'FloatTitle' },
        MiniFilesTitleFocused = { fg = colors.accent, bg = float_bg },

        -- Trouble
        TroubleNormal = { fg = colors.fg, bg = float_bg },
        TroubleText = { fg = colors.fg },
        TroubleCount = { fg = colors.purple },
        TroubleSignError = { fg = colors.diag_error },
        TroubleSignWarning = { fg = colors.diag_warn },

        -- Dashboard / Alpha
        DashboardHeader = { fg = colors.accent },
        DashboardCenter = { fg = colors.cyan },
        DashboardFooter = { fg = colors.fg_sub },
        AlphaHeader = { fg = colors.accent },
        AlphaButtons = { fg = colors.cyan },
        AlphaFooter = { fg = colors.fg_sub },

        -- Noice / Notify
        NoiceCmdline = { fg = colors.fg },
        NoiceCmdlineIcon = { fg = colors.cyan },
        NoicePopup = { fg = colors.fg, bg = float_bg },
    }

    local notify_levels = {
        ERROR = colors.diag_error,
        WARN = colors.diag_warn,
        INFO = colors.diag_info,
        DEBUG = colors.fg_sub,
        TRACE = colors.purple,
    }
    for level, color in pairs(notify_levels) do
        hl['Notify' .. level .. 'Border'] = { fg = color }
        hl['Notify' .. level .. 'Icon'] = { fg = color }
        hl['Notify' .. level .. 'Title'] = { fg = color }
        hl['Notify' .. level .. 'Body'] = { fg = colors.fg }
    end

    local completion_kinds = {
        Text = colors.fg_sub,
        Method = colors.green,
        Function = colors.green,
        Constructor = colors.teal,
        Field = colors.fg_dark,
        Variable = colors.cyan,
        Class = colors.purple,
        Interface = colors.purple,
        Module = colors.cyan,
        Property = colors.fg_dark,
        Unit = colors.orange,
        Value = colors.orange,
        Enum = colors.purple,
        Keyword = colors.indigo,
        Snippet = colors.green,
        Color = colors.teal,
        File = colors.fg,
        Reference = colors.cyan,
        Folder = colors.cyan,
        EnumMember = colors.cyan,
        Constant = colors.cyan,
        Struct = colors.purple,
        Event = colors.amber,
        Operator = colors.blue,
        TypeParameter = colors.purple,
    }
    for kind, color in pairs(completion_kinds) do
        hl['CmpItemKind' .. kind] = { fg = color }
        hl['BlinkCmpKind' .. kind] = { fg = color }
    end

    -- Disabling an integration omits our definitions without disabling the plugin.
    local plugins = config.plugins or {}
    local plugin_prefixes = {
        telescope = { 'Telescope' },
        nvimtree = { 'NvimTree' },
        neotree = { 'NeoTree' },
        oil = { 'Oil' },
        whichkey = { 'WhichKey' },
        gitsigns = { 'GitSigns' },
        cmp = { 'Cmp' },
        blink = { 'BlinkCmp' },
        indent_blankline = { 'IBL', 'IndentBlankline' },
        mini = { 'Mini' },
        trouble = { 'Trouble' },
        dashboard = { 'Dashboard' },
        alpha = { 'Alpha' },
        noice = { 'Noice' },
        notify = { 'Notify' },
        lsp = { 'Diagnostic', 'Lsp' },
        semantic_tokens = { '@lsp.' },
    }
    for plugin, prefixes in pairs(plugin_prefixes) do
        if plugins[plugin] == false then
            for group in pairs(hl) do
                for _, prefix in ipairs(prefixes) do
                    if group:sub(1, #prefix) == prefix then
                        hl[group] = nil
                        break
                    end
                end
            end
        end
    end
    if plugins.treesitter == false then
        for group in pairs(hl) do
            if group:sub(1, 1) == '@' and group:sub(1, 5) ~= '@lsp.' then
                hl[group] = nil
            end
        end
    end

    -- User custom highlights hook
    if type(config.on_highlights) == 'function' then
        config.on_highlights(hl, colors)
    end

    return hl
end

return M
