-- Test script for stealth.nvim
local ok, stealth = pcall(require, 'stealth')
if not ok then
    print('ERROR: Failed to require stealth module: ' .. tostring(stealth))
    os.exit(1)
end

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

print('--> Testing variants...')
local variants = { 'stealth', 'monochrome', 'emerald', 'cyan', 'violet', 'amber' }
for _, variant in ipairs(variants) do
    print('  Testing variant: ' .. variant)
    stealth.setup({ variant = variant })
    stealth.load()
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
assert(my_hl ~= nil, 'MyCustomHighlight should exist')

print('--> Testing Lualine module...')
local lualine_theme = stealth.lualine()
assert(lualine_theme.normal ~= nil, 'Lualine normal theme should exist')

print('SUCCESS: All stealth.nvim tests passed cleanly!')
