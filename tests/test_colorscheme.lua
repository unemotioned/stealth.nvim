-- Test script for stealth.nvim
local ok, stealth = pcall(require, 'stealth')
if not ok then
    print('ERROR: Failed to require stealth module: ' .. tostring(stealth))
    os.exit(1)
end

print('--> Testing load without setup...')
vim.cmd.colorscheme('stealth')
assert(vim.g.colors_name == 'stealth', 'colors_name should be stealth without setup')
assert(vim.g.terminal_color_0 == '#08090b', 'Default terminal colors should be initialized')
assert(stealth.highlights()['@variable.parameter'].italic == true, 'Default styles should be initialized')

print('--> Testing default setup & load...')
stealth.setup()
stealth.load()

assert(vim.g.colors_name == 'stealth', 'colors_name should be stealth')

local parameter_hl = vim.api.nvim_get_hl(0, { name = '@variable.parameter', link = false })
assert(parameter_hl.italic == true, 'Parameters should be italic by default')

print('--> Testing include keyword styles...')
local include_foregrounds = {}
for _, group in ipairs({ 'Include', '@keyword.import' }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.bold == true, group .. ' should be bold by default')
    include_foregrounds[group] = hl.fg
end
stealth.setup({ styles = { keywords = { bold = false, italic = true } } })
stealth.load()
for _, group in ipairs({ 'Include', '@keyword.import' }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(not hl.bold, group .. ' should not be bold')
    assert(hl.italic == true, group .. ' should honor keyword styles')
    assert(hl.fg == include_foregrounds[group], group .. ' should retain its foreground')
end

print('--> Testing parameter styles...')
stealth.setup({ styles = { parameters = { italic = false, bold = true } } })
stealth.load()
for _, group in ipairs({ '@variable.parameter', '@lsp.type.parameter' }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(not hl.italic, group .. ' should not be italic')
    assert(hl.bold == true, group .. ' should honor parameter styles')
    assert(hl.fg == parameter_hl.fg, group .. ' should retain its foreground')
end

print('--> Testing styles on specialized syntax captures...')
stealth.setup({
    styles = {
        keywords = { bold = false, italic = true },
        functions = { bold = true },
        variables = { italic = true },
        strings = { italic = true },
        constants = { bold = false, italic = true },
    },
})
stealth.load()
for _, group in ipairs({
    'Exception',
    'Define',
    'PreCondit',
    '@keyword.operator',
    '@keyword.directive',
    '@keyword.directive.define',
    '@keyword.exception',
    '@keyword.modifier',
    '@keyword.conditional.ternary',
}) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.italic and not hl.bold, group .. ' should honor keyword styles')
end
assert(vim.api.nvim_get_hl(0, { name = '@function.macro' }).bold, 'Function macros should honor function styles')
for _, group in ipairs({ '@variable.member', '@property', '@field', '@string.regexp', '@string.regex', '@string.escape' }) do
    assert(vim.api.nvim_get_hl(0, { name = group, link = false }).italic, group .. ' should honor its configured style')
end
local constant_macro = vim.api.nvim_get_hl(0, { name = '@constant.macro' })
assert(constant_macro.italic and not constant_macro.bold, 'Constant macros should honor constant styles')

print('--> Testing current and legacy Treesitter capture names...')
stealth.setup({
    on_highlights = function(hl)
        hl['@string.regexp'].fg = '#123456'
        hl['@number.float'].fg = '#234567'
        hl['@markup.strong'].italic = true
    end,
})
stealth.load()
for _, group in ipairs({ '@string.regexp', '@string.regex', '@lsp.type.regexp' }) do
    assert(vim.api.nvim_get_hl(0, { name = group, link = false }).fg == 0x123456, group .. ' should use regexp styling')
end
for _, group in ipairs({ '@number.float', '@float' }) do
    assert(vim.api.nvim_get_hl(0, { name = group, link = false }).fg == 0x234567, group .. ' should use float styling')
end
for _, group in ipairs({ '@markup.strong', '@markup.bold' }) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.bold and hl.italic, group .. ' should use strong markup styling')
end

print('--> Testing variants...')
local variants = { 'stealth', 'monochrome', 'emerald', 'cyan', 'violet', 'amber' }
local variant_accents = {
    stealth = 0x818cf8,
    monochrome = 0xffffff,
    emerald = 0x34d399,
    cyan = 0x38bdf8,
    violet = 0xc084fc,
    amber = 0xf59e0b,
}
for _, variant in ipairs(variants) do
    print('  Testing variant: ' .. variant)
    stealth.setup({ variant = variant })
    stealth.load()
    local title = vim.api.nvim_get_hl(0, { name = 'Title' })
    assert(title.fg == variant_accents[variant], variant .. ' should apply its accent color')
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local expected_bg = variant == 'monochrome' and 0x101010 or 0x0e1013
    assert(normal.bg == expected_bg, variant .. ' should apply its background')
end

print('--> Testing monochrome palette...')
stealth.setup({ variant = 'monochrome' })
local monochrome = stealth.colors()
for _, key in ipairs({
    'bg',
    'fg',
    'comment',
    'amber',
    'green',
    'teal',
    'cyan',
    'blue',
    'indigo',
    'purple',
    'git_add',
    'git_change',
    'git_delete',
    'git_dirty',
    'diff_add',
    'diff_change',
    'diff_delete',
    'diff_text',
    'diag_warn',
    'diag_info',
    'diag_hint',
    'diag_ok',
    'diag_bg_warn',
    'diag_bg_info',
    'diag_bg_hint',
    'diag_bg_ok',
}) do
    local color = monochrome[key]
    assert(color:sub(2, 3) == color:sub(4, 5) and color:sub(4, 5) == color:sub(6, 7), key .. ' should be grey')
end
assert(monochrome.diag_error == '#f43f5e', 'Monochrome should retain red errors')
assert(monochrome.orange == '#fb923c', 'Monochrome should retain orange literals')
local monochrome_hl = stealth.highlights()
assert(monochrome_hl.Number.fg == monochrome.orange, 'Numbers should use the monochrome palette')
assert(monochrome_hl.DiffChange.bg == monochrome.diff_change, 'Diff backgrounds should use the palette')
assert(monochrome_hl.DiagnosticVirtualTextInfo.bg == monochrome.diag_bg_info, 'Diagnostic backgrounds should use the palette')

print('--> Testing orange literal highlights...')
local literal_groups = {
    'Number', 'Float', 'Boolean', '@number', '@number.float', '@float', '@boolean',
    '@constant.builtin', '@lsp.type.number',
}
for _, variant in ipairs(variants) do
    stealth.setup({ variant = variant })
    stealth.load()
    for _, group in ipairs(literal_groups) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        assert(hl.fg == 0xfb923c, variant .. ' ' .. group .. ' should be orange')
    end
end
stealth.setup({
    variant = 'monochrome',
    on_colors = function(colors)
        colors.orange = '#123456'
    end,
})
stealth.load()
for _, group in ipairs(literal_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.fg == 0x123456, group .. ' should honor the orange palette override')
end

print('--> Testing comment and inlay hint contrast...')
local function luminance(hex)
    local components = {}
    for i = 2, 6, 2 do
        local value = tonumber(hex:sub(i, i + 1), 16) / 255
        components[#components + 1] = value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * components[1] + 0.7152 * components[2] + 0.0722 * components[3]
end
for _, variant in ipairs(variants) do
    stealth.setup({ variant = variant })
    local palette = stealth.colors()
    local hl = stealth.highlights()
    local background = luminance(palette.bg)
    for _, group in ipairs({ 'Comment', 'LspInlayHint' }) do
        local foreground = luminance(hl[group].fg)
        local ratio = (math.max(foreground, background) + 0.05) / (math.min(foreground, background) + 0.05)
        assert(ratio >= 4.5, variant .. ' ' .. group .. ' should have at least 4.5:1 contrast')
    end
end

print('--> Testing custom options & overrides...')
stealth.setup({
    transparent = true,
    styles = {
        comments = { italic = true, bold = true },
        keywords = { italic = true, bold = true },
        functions = { bold = true },
    },
    on_colors = function(c)
        c.my_custom_color = '#ff00ff'
    end,
    on_highlights = function(hl, c)
        hl.MyCustomHighlight = { fg = c.my_custom_color }
    end,
})
stealth.load()

local my_hl = vim.api.nvim_get_hl(0, { name = 'MyCustomHighlight' })
assert(my_hl.fg == 0xff00ff, 'MyCustomHighlight should use the custom color')

print('--> Testing transparent inverse text and terminal colors...')
for _, group in ipairs({
    'Cursor',
    'IncSearch',
    'CurSearch',
    'Substitute',
    'Todo',
    '@comment.note',
    '@comment.todo',
    'TelescopePromptTitle',
}) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.fg == 0x0e1013, group .. ' should retain a solid foreground')
end
assert(vim.g.terminal_color_0 == '#08090b', 'Terminal black should remain a valid solid color')

print('--> Testing Lualine module...')
local lualine_theme = stealth.lualine()
assert(lualine_theme.normal.a.bg == '#818cf8', 'Lualine should use the configured palette')
assert(lualine_theme.normal.a.fg == '#0e1013', 'Lualine should retain a solid foreground')
for _, mode in ipairs({ 'normal', 'insert', 'visual', 'replace', 'command' }) do
    assert(lualine_theme[mode].a.gui == 'bold', 'Lualine ' .. mode .. ' mode should use its bold style')
end
local lualine_files = vim.api.nvim_get_runtime_file('lua/lualine/themes/stealth.lua', false)
assert(#lualine_files == 1, 'Lualine should be able to discover the stealth theme')
assert(dofile(lualine_files[1]).normal.a.bg == lualine_theme.normal.a.bg, 'Discovered Lualine theme should match')
stealth.setup({ variant = 'emerald' })
assert(dofile(lualine_files[1]).normal.a.bg == '#34d399', 'Lualine discovery should reflect the current variant')

stealth.setup({
    transparent = true,
    on_colors = function(c)
        c.bg_base = '#010203'
        c.bg_dark_base = '#040506'
    end,
})
stealth.load()
assert(vim.api.nvim_get_hl(0, { name = 'Todo' }).fg == 0x010203, 'Solid background override should be used')
assert(vim.g.terminal_color_0 == '#040506', 'Solid terminal background override should be used')
assert(stealth.lualine().normal.a.fg == '#010203', 'Lualine should use the solid background override')

print('--> Testing float and sidebar backgrounds...')
local function assert_backgrounds(options, expected)
    stealth.setup(options)
    local hl = stealth.highlights()
    for group, bg in pairs(expected) do
        assert(hl[group].bg == bg, group .. ' background should be ' .. bg)
    end
end

assert_backgrounds({}, {
    Normal = '#0e1013',
    NormalFloat = '#12151b',
    NvimTreeNormal = '#090a0d',
})
assert_backgrounds({ transparent = true }, {
    Normal = 'NONE',
    NormalFloat = 'NONE',
    FloatBorder = 'NONE',
    FloatTitle = 'NONE',
    FloatFooter = 'NONE',
    NvimTreeNormal = 'NONE',
    NeoTreeNormal = 'NONE',
    TelescopeNormal = 'NONE',
    TelescopeBorder = 'NONE',
    TelescopePromptNormal = 'NONE',
    TelescopePromptBorder = 'NONE',
    WhichKeyNormal = 'NONE',
    WhichKeyBorder = 'NONE',
    TroubleNormal = 'NONE',
    NoicePopup = 'NONE',
})
assert_backgrounds({ styles = { floats = 'transparent', sidebars = 'transparent' } }, {
    Normal = '#0e1013',
    NormalFloat = 'NONE',
    NvimTreeNormal = 'NONE',
    TelescopePromptNormal = 'NONE',
})
assert_backgrounds({ styles = { floats = 'normal', sidebars = 'normal' } }, {
    NormalFloat = '#0e1013',
    FloatTitle = '#0e1013',
    NvimTreeNormal = '#0e1013',
    TelescopePromptNormal = '#0e1013',
})
assert_backgrounds({ transparent = true, styles = { floats = 'dark', sidebars = 'dark' } }, {
    Normal = 'NONE',
    NormalFloat = '#12151b',
    NvimTreeNormal = '#090a0d',
})

print('--> Testing dark background when switching from a light scheme...')
vim.cmd.colorscheme('default')
vim.o.background = 'light'
local palette_loads = 0
stealth.setup({
    on_colors = function()
        palette_loads = palette_loads + 1
    end,
})
vim.cmd.colorscheme('stealth')
assert(vim.o.background == 'dark', 'Stealth should select dark background defaults')
assert(vim.g.colors_name == 'stealth', 'Stealth should remain the active colorscheme')
assert(palette_loads == 1, 'Changing the background should not reload Stealth recursively')

print('--> Testing window, diff, and OK diagnostic highlights...')
stealth.setup({
    on_colors = function(c)
        c.git_add = '#123456'
        c.git_change = '#234567'
        c.git_delete = '#345678'
        c.diag_ok = '#456789'
    end,
})
stealth.load()
for group, expected in pairs({
    Added = 0x123456,
    Changed = 0x234567,
    Removed = 0x345678,
    ['@diff.plus'] = 0x123456,
    ['@diff.delta'] = 0x234567,
    ['@diff.minus'] = 0x345678,
    DiagnosticOk = 0x456789,
    DiagnosticVirtualTextOk = 0x456789,
}) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    assert(hl.fg == expected, group .. ' should use the configured palette')
end
assert(vim.api.nvim_get_hl(0, { name = 'WinBar' }).bg == 0x08090b, 'WinBar should use the theme background')
assert(vim.api.nvim_get_hl(0, { name = 'WinBarNC' }).bg == 0x08090b, 'WinBarNC should use the theme background')
assert(
    vim.api.nvim_get_hl(0, { name = 'DiagnosticUnderlineOk' }).sp == 0x456789,
    'DiagnosticUnderlineOk should use the configured palette'
)

print('--> Testing completion highlights...')
stealth.setup({ styles = { floats = 'transparent' } })
stealth.load()
local deprecated = vim.api.nvim_get_hl(0, { name = 'BlinkCmpLabelDeprecated' })
assert(deprecated.strikethrough, 'Blink deprecated completions should be struck through')
local completion_kinds = {
    'Text', 'Method', 'Function', 'Constructor', 'Field', 'Variable', 'Class', 'Interface', 'Module',
    'Property', 'Unit', 'Value', 'Enum', 'Keyword', 'Snippet', 'Color', 'File', 'Reference', 'Folder',
    'EnumMember', 'Constant', 'Struct', 'Event', 'Operator', 'TypeParameter',
}
for _, kind in ipairs(completion_kinds) do
    local cmp = vim.api.nvim_get_hl(0, { name = 'CmpItemKind' .. kind })
    local blink = vim.api.nvim_get_hl(0, { name = 'BlinkCmpKind' .. kind })
    assert(cmp.fg and cmp.fg == blink.fg, kind .. ' should have matching completion colors')
end
assert(
    vim.api.nvim_get_hl(0, { name = 'BlinkCmpDocBorder' }).bg == nil,
    'Blink documentation borders should follow float transparency'
)
stealth.setup({ plugins = { cmp = false } })
local blink_only = stealth.highlights()
assert(blink_only.CmpItemKindMethod == nil, 'Disabling cmp should omit its completion kinds')
assert(blink_only.BlinkCmpKindMethod ~= nil, 'Disabling cmp should not disable Blink kinds')
assert(blink_only.BlinkCmpLabelDeprecated.strikethrough, 'Blink deprecation should not depend on cmp')

print('--> Testing Mini.nvim highlights...')
stealth.setup({ transparent = true })
local mini_hl = stealth.highlights()
local mini_groups = {
    'MiniStatuslineModeNormal', 'MiniStatuslineModeInsert', 'MiniStatuslineModeVisual',
    'MiniStatuslineModeReplace', 'MiniStatuslineModeCommand', 'MiniStatuslineModeOther',
    'MiniStatuslineDevinfo', 'MiniStatuslineFilename', 'MiniStatuslineFileinfo', 'MiniStatuslineInactive',
    'MiniPickNormal', 'MiniPickBorder', 'MiniPickBorderBusy', 'MiniPickBorderText', 'MiniPickCursor',
    'MiniPickIconDirectory', 'MiniPickIconFile', 'MiniPickHeader', 'MiniPickMatchCurrent',
    'MiniPickMatchMarked', 'MiniPickMatchRanges', 'MiniPickPreviewLine', 'MiniPickPreviewRegion',
    'MiniPickPrompt', 'MiniPickPromptCaret', 'MiniPickPromptPrefix',
    'MiniStarterCurrent', 'MiniStarterFooter', 'MiniStarterHeader', 'MiniStarterInactive',
    'MiniStarterItem', 'MiniStarterItemBullet', 'MiniStarterItemPrefix', 'MiniStarterSection', 'MiniStarterQuery',
    'MiniFilesBorder', 'MiniFilesBorderModified', 'MiniFilesCursorLine', 'MiniFilesDirectory',
    'MiniFilesFile', 'MiniFilesNormal', 'MiniFilesTitle', 'MiniFilesTitleFocused',
}
for _, group in ipairs(mini_groups) do
    assert(mini_hl[group] ~= nil, group .. ' should be defined')
end
stealth.load()
assert(vim.api.nvim_get_hl(0, { name = 'MiniFilesNormal', link = false }).bg == nil, 'Mini files should be transparent')
assert(vim.api.nvim_get_hl(0, { name = 'MiniPickNormal', link = false }).bg == nil, 'Mini pick should be transparent')
assert(
    vim.api.nvim_get_hl(0, { name = 'MiniStatuslineModeNormal' }).fg == 0x0e1013,
    'Mini statusline mode text should keep a solid foreground'
)
stealth.setup({ plugins = { mini = false } })
local no_mini = stealth.highlights()
for _, group in ipairs(mini_groups) do
    assert(no_mini[group] == nil, 'The mini switch should omit ' .. group)
end

print('--> Testing Oil.nvim highlights...')
stealth.setup()
local oil_hl = stealth.highlights()
local oil_groups = {
    'OilEmpty', 'OilHidden', 'OilDir', 'OilDirHidden', 'OilDirIcon', 'OilSocket',
    'OilSocketHidden', 'OilLink', 'OilOrphanLink', 'OilLinkHidden', 'OilOrphanLinkHidden',
    'OilLinkTarget', 'OilOrphanLinkTarget', 'OilLinkTargetHidden', 'OilOrphanLinkTargetHidden',
    'OilFile', 'OilFileHidden', 'OilCreate', 'OilDelete', 'OilMove', 'OilCopy', 'OilChange',
    'OilRestore', 'OilPurge', 'OilTrash', 'OilTrashSourcePath',
}
for _, group in ipairs(oil_groups) do
    assert(oil_hl[group] ~= nil, group .. ' should be defined')
end
stealth.load()
assert(
    vim.api.nvim_get_hl(0, { name = 'OilDir', link = false }).fg
        == vim.api.nvim_get_hl(0, { name = 'Directory' }).fg,
    'Oil directories should follow the theme directory color'
)
stealth.setup({ plugins = { oil = false } })
local no_oil = stealth.highlights()
for _, group in ipairs(oil_groups) do
    assert(no_oil[group] == nil, 'The oil switch should omit ' .. group)
end

print('--> Testing nvim-notify highlights...')
stealth.setup()
local notify_hl = stealth.highlights()
for _, level in ipairs({ 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE' }) do
    local prefix = 'Notify' .. level
    for _, section in ipairs({ 'Border', 'Icon', 'Title', 'Body' }) do
        assert(notify_hl[prefix .. section] ~= nil, prefix .. section .. ' should be defined')
    end
    assert(notify_hl[prefix .. 'Border'].fg == notify_hl[prefix .. 'Icon'].fg, prefix .. ' colors should match')
    assert(notify_hl[prefix .. 'Title'].bold, prefix .. ' title should be bold')
end
stealth.setup({ plugins = { notify = false } })
local no_notify = stealth.highlights()
for _, level in ipairs({ 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE' }) do
    for _, section in ipairs({ 'Border', 'Icon', 'Title', 'Body' }) do
        assert(no_notify['Notify' .. level .. section] == nil, 'The notify switch should omit all notification groups')
    end
end

print('--> Testing syntax reset only when syntax is enabled...')
vim.cmd('syntax off')
vim.g.colors_name = nil
vim.api.nvim_set_hl(0, 'StatusLineTerm', { fg = '#123456' })
stealth.load()
local terminal_hl = vim.api.nvim_get_hl(0, { name = 'StatusLineTerm', link = false })
assert(terminal_hl.fg == 0x123456, 'Syntax reset should not run while syntax is disabled')

vim.cmd('syntax on')
vim.g.colors_name = nil
vim.api.nvim_set_hl(0, 'StatusLineTerm', { fg = '#123456' })
stealth.load()
terminal_hl = vim.api.nvim_get_hl(0, { name = 'StatusLineTerm', link = false })
assert(terminal_hl.fg ~= 0x123456, 'Syntax reset should run while syntax is enabled')

print('--> Testing integration switches...')
local integrations = {
    telescope = 'TelescopeNormal',
    nvimtree = 'NvimTreeNormal',
    neotree = 'NeoTreeNormal',
    oil = 'OilDir',
    whichkey = 'WhichKey',
    gitsigns = 'GitSignsAdd',
    cmp = 'CmpItemAbbr',
    blink = 'BlinkCmpLabel',
    indent_blankline = 'IBLIndent',
    trouble = 'TroubleNormal',
    dashboard = 'DashboardHeader',
    alpha = 'AlphaHeader',
    noice = 'NoicePopup',
    notify = 'NotifyERRORBorder',
    treesitter = '@keyword',
    lsp = 'DiagnosticError',
    semantic_tokens = '@lsp.type.function',
}
for integration, group in pairs(integrations) do
    stealth.setup({ plugins = { [integration] = false } })
    local hl = stealth.highlights()
    assert(hl[group] == nil, integration .. ' should omit ' .. group)
    assert(hl.Normal ~= nil, integration .. ' should not omit core highlights')
end
stealth.setup({
    plugins = { telescope = false, treesitter = false },
    on_highlights = function(hl)
        assert(hl.TelescopeNormal == nil, 'Integration filtering should run before the user hook')
        hl.TelescopeNormal = { fg = '#123456' }
    end,
})
local filtered_hl = stealth.highlights()
assert(filtered_hl.TelescopeNormal.fg == '#123456', 'User hooks should be able to restore disabled highlights')
assert(filtered_hl['@lsp.type.function'] ~= nil, 'Treesitter and semantic token switches should be independent')
stealth.setup()
stealth.load()
stealth.setup({ plugins = { telescope = false } })
stealth.load()
assert(
    vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = 'TelescopeNormal' })),
    'Disabling an integration and reloading should clear its previous highlights'
)

print('SUCCESS: All stealth.nvim tests passed cleanly!')
