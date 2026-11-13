local M = {}

local config = require('stealth.config')
local colors_mod = require('stealth.colors')
local highlights_mod = require('stealth.highlights')
local terminal_mod = require('stealth.terminal')

---Setup Stealth colorscheme with options
---@param options StealthConfig|nil
function M.setup(options)
    config.setup(options)
end

---Load Stealth colorscheme into Neovim
function M.load()
    local previous_scheme = vim.g.colors_name
    if vim.o.background ~= 'dark' then
        -- Avoid reloading the previous colorscheme when changing 'background'.
        vim.g.colors_name = nil
        vim.o.background = 'dark'
    end
    if previous_scheme then
        vim.cmd('hi clear')
    end
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end

    vim.o.termguicolors = true
    vim.g.colors_name = 'stealth'

    local opts = config.options
    local palette = colors_mod.setup(opts)
    local highlights = highlights_mod.setup(palette, opts)

    -- Apply highlight groups
    for group, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, hl)
    end

    -- Apply terminal colors if enabled
    if opts.terminal_colors then
        terminal_mod.setup(palette)
    end
end

---Get color palette table
---@return table
function M.colors()
    return colors_mod.setup(config.options)
end

---Get highlights table
---@return table
function M.highlights()
    local palette = colors_mod.setup(config.options)
    return highlights_mod.setup(palette, config.options)
end

---Get Lualine theme module
---@return table
function M.lualine()
    return require('stealth.lualine').get()
end

return M
