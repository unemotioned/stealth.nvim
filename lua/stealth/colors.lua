local M = {}

---Generate theme palette based on configuration
---@param config StealthConfig
---@return table
function M.setup(config)
    config = config or require('stealth.config').options

    -- Monochrome Monkeytype Stealth palette
    local palette = {
        none = 'NONE',

        -- Base backgrounds (Matte black / ultra-dark charcoal aesthetic)
        bg = '#0e1013',
        bg_dark = '#08090b',
        bg_float = '#12151b',
        bg_highlight = '#181b22',
        bg_visual = '#262b35',
        bg_search = '#383f4f',
        bg_line = '#15181e',
        bg_sidebar = '#090a0d',
        bg_popup = '#13161c',

        -- Borders & Separators
        border = '#2b313d',
        border_highlight = '#4b5568',
        win_separator = '#232833',

        -- Foreground & Text Hierarchy (Monkeytype stealth inspired)
        fg = '#e2e8f0',
        fg_dark = '#cbd5e1',
        fg_gutter = '#3b4352',
        fg_sub = '#64748b', -- Monkeytype sub color
        fg_dim = '#3f4756', -- Stealth dim text
        comment = '#818181',

        -- Main monkeytype accent (bright white / main highlight)
        main = '#ffffff',
        accent = '#ffffff',

        -- Syntax colors (orange literals and red errors)
        red = '#f43f5e', -- Monkeytype error red
        red_dark = '#7f1d1d',
        orange = '#fb923c',
        amber = '#d4d4d8',
        yellow = '#d4d4d4',
        green = '#a1a1aa',
        emerald = '#a1a1a1',
        teal = '#71717a',
        cyan = '#cbd5e1',
        blue = '#cbd5e1',
        indigo = '#94a3b8',
        purple = '#e2e8f0',
        magenta = '#d0d0d0',
        pink = '#d0d0d0',

        -- Git & Diff Colors
        git_add = '#a1a1a1',
        git_change = '#bcbcbc',
        git_delete = '#d4d4d4',
        git_dirty = '#c4c4c4',
        diff_add = '#1c1c1c',
        diff_change = '#202020',
        diff_delete = '#262626',
        diff_text = '#383838',

        -- Diagnostic Colors
        diag_error = '#f43f5e',
        diag_warn = '#d4d4d4',
        diag_info = '#cbcbcb',
        diag_hint = '#a1a1a1',
        diag_ok = '#a1a1a1',
        diag_bg_error = '#29151c',
        diag_bg_warn = '#242424',
        diag_bg_info = '#202020',
        diag_bg_hint = '#1c1c1c',
        diag_bg_ok = '#1c1c1c',
    }

    -- Keep solid colors for inverse text and terminal colors in transparent mode.
    palette.bg_base = palette.bg
    palette.bg_dark_base = palette.bg_dark

    -- Transparent background handling
    if config.transparent then
        palette.bg = 'NONE'
        palette.bg_dark = 'NONE'
    end

    -- User custom colors hook
    if type(config.on_colors) == 'function' then
        config.on_colors(palette)
    end

    return palette
end

return M
