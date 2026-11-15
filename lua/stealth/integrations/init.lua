local M = {}

---@class StealthHighlightContext
---@field styles StealthStyles
---@field inverse_fg string
---@field float_bg string
---@field sidebar_bg string
---@field prompt_bg string

local integrations = {
    'alpha',
    'blink',
    'cmp',
    'dashboard',
    'gitsigns',
    'indent_blankline',
    'lsp',
    'mini',
    'neotree',
    'nvimtree',
    'oil',
    'semantic_tokens',
    'telescope',
    'treesitter',
    'trouble',
    'whichkey',
}

---Generate enabled integration highlights.
---@param colors table
---@param config StealthConfig
---@param context StealthHighlightContext
---@return table<string, table>
function M.get(colors, config, context)
    local highlights = {}
    local plugins = config.plugins or {}

    for _, name in ipairs(integrations) do
        if plugins[name] ~= false then
            local groups = require('stealth.integrations.' .. name).get(colors, context)
            for group, definition in pairs(groups) do
                highlights[group] = definition
            end
        end
    end

    return highlights
end

return M
