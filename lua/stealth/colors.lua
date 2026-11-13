local M = {}

---Generate theme palette based on configuration
---@param config StealthConfig
---@return table
function M.setup(config)
    config = config or require('stealth.config').options
    local variant = config.variant or 'stealth'

    -- Core Monkeytype Stealth palette
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
        comment = '#7b8799', -- Readable comment slate grey

        -- Main monkeytype accent (bright white / main highlight)
        main = '#ffffff',
        accent = '#818cf8',

        -- Syntax Colors (Rich contrast & personalization)
        red = '#f43f5e', -- Monkeytype error red
        red_dark = '#7f1d1d',
        orange = '#fb923c',
        amber = '#f59e0b',
        yellow = '#eab308',
        green = '#34d399', -- Emerald mint for functions/strings
        emerald = '#10b981',
        teal = '#2dd4bf',
        cyan = '#38bdf8', -- Sky cyan for types/constants
        blue = '#60a5fa', -- Soft blue for keywords
        indigo = '#818cf8', -- Indigo for keywords/operators
        purple = '#c084fc', -- Soft purple for control flow/tags
        magenta = '#e879f9',
        pink = '#f472b6',

        -- Git & Diff Colors
        git_add = '#34d399',
        git_change = '#60a5fa',
        git_delete = '#f43f5e',
        git_dirty = '#fb923c',
        diff_add = '#142e23',
        diff_change = '#16273b',
        diff_delete = '#3b171f',
        diff_text = '#25476d',

        -- Diagnostic Colors
        diag_error = '#f43f5e',
        diag_warn = '#f59e0b',
        diag_info = '#38bdf8',
        diag_hint = '#34d399',
        diag_ok = '#34d399',
        diag_bg_error = '#29151c',
        diag_bg_warn = '#292115',
        diag_bg_info = '#152329',
        diag_bg_hint = '#152922',
        diag_bg_ok = '#152922',
    }

    -- Apply variant overrides
    if variant == 'monochrome' then
        palette.comment = '#818181'
        palette.accent = '#ffffff'
        palette.amber = '#d4d4d8'
        palette.yellow = '#d4d4d4'
        palette.green = '#a1a1aa'
        palette.emerald = '#a1a1a1'
        palette.teal = '#71717a'
        palette.cyan = '#cbd5e1'
        palette.blue = '#cbd5e1'
        palette.indigo = '#94a3b8'
        palette.purple = '#e2e8f0'
        palette.magenta = '#d0d0d0'
        palette.pink = '#d0d0d0'
        palette.git_add = '#a1a1a1'
        palette.git_change = '#bcbcbc'
        palette.git_delete = '#d4d4d4'
        palette.git_dirty = '#c4c4c4'
        palette.diff_add = '#1c1c1c'
        palette.diff_change = '#202020'
        palette.diff_delete = '#262626'
        palette.diff_text = '#383838'
        palette.diag_warn = '#d4d4d4'
        palette.diag_info = '#cbcbcb'
        palette.diag_hint = '#a1a1a1'
        palette.diag_ok = '#a1a1a1'
        palette.diag_bg_warn = '#242424'
        palette.diag_bg_info = '#202020'
        palette.diag_bg_hint = '#1c1c1c'
        palette.diag_bg_ok = '#1c1c1c'
    elseif variant == 'emerald' then
        palette.accent = '#34d399'
        palette.blue = '#34d399'
        palette.indigo = '#2dd4bf'
        palette.purple = '#a7f3d0'
        palette.cyan = '#6ee7b7'
    elseif variant == 'cyan' then
        palette.accent = '#38bdf8'
        palette.blue = '#38bdf8'
        palette.indigo = '#60a5fa'
        palette.purple = '#7dd3fc'
        palette.green = '#22d3ee'
    elseif variant == 'violet' then
        palette.accent = '#c084fc'
        palette.blue = '#c084fc'
        palette.indigo = '#a855f7'
        palette.purple = '#e879f9'
        palette.cyan = '#818cf8'
    elseif variant == 'amber' then
        palette.accent = '#f59e0b'
        palette.blue = '#fb923c'
        palette.indigo = '#f59e0b'
        palette.purple = '#fbbf24'
        palette.green = '#fcd34d'
    end

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
