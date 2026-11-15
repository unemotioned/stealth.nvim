local M = {}

function M.get(colors, context)
    local styles = context.styles
    local comment_style = styles.comments or {}
    local keyword_style = styles.keywords or {}
    local function_style = styles.functions or {}
    local variable_style = styles.variables or {}
    local parameter_style = styles.parameters or {}
    local string_style = styles.strings or {}
    local constant_style = styles.constants or {}
    local type_style = styles.types or {}
    local inverse_fg = context.inverse_fg

    return {
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
    }
end

return M
