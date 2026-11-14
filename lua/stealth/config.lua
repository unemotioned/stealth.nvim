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
---@field transparent boolean
---@field dim_inactive boolean
---@field terminal_colors boolean
---@field styles StealthStyles
---@field plugins table<string, boolean>
---@field on_colors fun(colors: table): nil
---@field on_highlights fun(highlights: table, colors: table): nil

---@type StealthConfig
M.defaults = {
    transparent = false,
    dim_inactive = false,
    terminal_colors = true,
    styles = {
        comments = { bold = false, italic = false },
        keywords = { bold = false, italic = false },
        functions = { bold = false, italic = false },
        variables = { bold = false, italic = false },
        parameters = { bold = false, italic = false },
        strings = { bold = false, italic = false },
        constants = { bold = false, italic = false },
        types = { bold = false, italic = false },
        sidebars = 'auto', ---@type 'auto'|'dark'|'transparent'|'normal'
        floats = 'auto', ---@type 'auto'|'dark'|'transparent'|'normal'
    },
    plugins = {
        alpha = true,
        blink = true,
        cmp = true,
        dashboard = true,
        gitsigns = true,
        indent_blankline = true,
        lsp = true,
        mini = true,
        neotree = true,
        nvimtree = true,
        oil = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        trouble = true,
        whichkey = true,
    },
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
}

---@type StealthConfig
M.options = vim.deepcopy(M.defaults)

---Setup user configuration
---@param options StealthConfig|nil
function M.setup(options)
    M.options = vim.tbl_deep_extend('force', {}, M.defaults, options or {})
end

return M
