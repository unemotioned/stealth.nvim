local M = {}

---@class StealthStyles
---@field comments table<string, boolean>
---@field keywords table<string, boolean>
---@field functions table<string, boolean>
---@field variables table<string, boolean>
---@field parameters table<string, boolean>
---@field strings table<string, boolean>
---@field constants table<string, boolean>
---@field types table<string, boolean>
---@field sidebars string|table<string, boolean>
---@field floats string|table<string, boolean>

---@class StealthConfig
---@field variant string|'"stealth"'|'"monochrome"'|'"emerald"'|'"cyan"'|'"violet"'|'"amber"'
---@field transparent boolean
---@field dim_inactive boolean
---@field terminal_colors boolean
---@field styles StealthStyles
---@field plugins table<string, boolean>
---@field on_colors fun(colors: table): nil
---@field on_highlights fun(highlights: table, colors: table): nil

---@type StealthConfig
M.defaults = {
    variant = 'stealth', -- "stealth" (default), "monochrome", "emerald", "cyan", "violet", "amber"
    transparent = false,
    dim_inactive = false,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = false, bold = true },
        functions = { italic = false, bold = false },
        variables = { italic = false },
        parameters = { italic = true },
        strings = { italic = false },
        constants = { bold = true },
        types = { bold = false },
        sidebars = 'dark', -- "dark", "transparent", or "normal"
        floats = 'dark', -- "dark", "transparent", or "normal"
    },
    plugins = {
        telescope = true,
        nvimtree = true,
        neotree = true,
        whichkey = true,
        gitsigns = true,
        cmp = true,
        blink = true,
        treesitter = true,
        lsp = true,
        semantic_tokens = true,
        lualine = true,
        bufferline = true,
        barbar = true,
        indent_blankline = true,
        mini = true,
        trouble = true,
        dashboard = true,
        noice = true,
        notify = true,
    },
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
}

---@type StealthConfig
M.options = {}

---Setup user configuration
---@param options StealthConfig|nil
function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, M.defaults, options or {})
end

return M
