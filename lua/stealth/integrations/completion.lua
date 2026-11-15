local M = {}

---Colors shared by completion integrations.
---@param colors table
---@return table<string, string>
function M.kinds(colors)
    return {
        Text = colors.fg_sub,
        Method = colors.green,
        Function = colors.green,
        Constructor = colors.teal,
        Field = colors.fg_dark,
        Variable = colors.cyan,
        Class = colors.purple,
        Interface = colors.purple,
        Module = colors.cyan,
        Property = colors.fg_dark,
        Unit = colors.orange,
        Value = colors.orange,
        Enum = colors.purple,
        Keyword = colors.indigo,
        Snippet = colors.green,
        Color = colors.teal,
        File = colors.fg,
        Reference = colors.cyan,
        Folder = colors.cyan,
        EnumMember = colors.cyan,
        Constant = colors.cyan,
        Struct = colors.purple,
        Event = colors.amber,
        Operator = colors.blue,
        TypeParameter = colors.purple,
    }
end

return M
