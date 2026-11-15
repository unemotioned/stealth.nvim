local M = {}

function M.get()
    return {
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
    }
end

return M
