# 🥷 stealth.nvim

An ultra-minimalist, matte-black, high-contrast Neovim colorscheme inspired by
**Monkeytype's Stealth** theme.

Designed with precision for focus, clarity, and modern Neovim features.
Personalized token styling for comments, keywords, functions, variables,
strings, types, and rich integration with popular Neovim plugins.

---

## ✨ Features

- 🎯 **Monkeytype Stealth Aesthetic**: Deep matte-black backgrounds, crisp
  white accents, and slate grey secondary hierarchy.
- 🎨 **Monochrome Palette**: Cool charcoal and slate-white tones, with orange
  literals, yellow warnings, and red errors.
- 💬 **Personalized Syntax Highlights**: Customize styles (`italic`, `bold`,
  `undercurl`) for comments, keywords, functions, variables, constants, and types.
- 🪟 **Transparent Mode**: Toggle transparent background for floating windows,
  sidebars, or the entire editor.
- ⚡ **Plugin Highlight Integrations**:
  - Treesitter & Semantic Tokens (`@lsp.type.*`)
  - Native LSP & Diagnostics
  - Telescope.nvim
  - NvimTree / Neo-Tree / Oil.nvim
  - WhichKey.nvim
  - Gitsigns.nvim
  - Nvim-Cmp & Blink.cmp
  - Indent-Blankline / IBL
  - Mini.nvim (Statusline, Pick, Starter, Files)
  - Trouble.nvim
  - Dashboard-nvim / Alpha-nvim
- 📊 **Lualine Theme Integration**: Included out-of-the-box via `theme = "stealth"`.
- 💻 **Terminal Colors**: Automatic setup for `:terminal` colors (`vim.g.terminal_color_*`).

---

## ⚡ Installation

For the default settings, `:colorscheme stealth` also works without calling
`setup()`.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "LucFerrei/stealth.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
        require("stealth").setup(opts)
        vim.cmd.colorscheme("stealth")
    end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    'LucFerrei/stealth.nvim',
    config = function()
        require('stealth').setup()
        vim.cmd('colorscheme stealth')
    end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'LucFerrei/stealth.nvim'

" In your lua configuration
lua << EOF
    require('stealth').setup()
    vim.cmd('colorscheme stealth')
EOF
```

---

## ⚙️ Configuration Options

Default settings can be overridden by passing a configuration table to `setup()`:

```lua
require("stealth").setup({
    -- Enable transparent background
    transparent = false,

    -- Dim background of inactive windows
    dim_inactive = false,

    -- Set terminal colors (vim.g.terminal_color_*)
    terminal_colors = true,

    -- Personalized syntax styles
    styles = {
        comments = { bold = false, italic = false },
        keywords = { bold = false, italic = false },
        functions = { bold = false, italic = false },
        variables = { bold = false, italic = false },
        parameters = { bold = false, italic = false },
        strings = { bold = false, italic = false },
        constants = { bold = false, italic = false },
        types = { bold = false, italic = false },
        sidebars = "auto", ---@type 'auto'|'dark'|'transparent'|'normal'
        floats = "auto", ---@type 'auto'|'dark'|'transparent'|'normal'
    },

    -- Set an integration to false to omit Stealth's highlight definitions
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

    -- Override colors
    on_colors = function(colors)
        colors.comment = "#8996a8" -- Customize comment color
        colors.accent = "#eeeeee" -- Customize accent
    end,

    -- Override highlight groups
    on_highlights = function(highlights, colors)
        highlights.Comment = { fg = colors.comment }
        highlights.Function = { fg = colors.green }
    end,
})

vim.cmd.colorscheme("stealth")
```

Bold and italic are disabled by default, including for Markdown emphasis and
themed plugin highlights. Set a syntax style to `true` or use `on_highlights`
to enable either style for specific groups.

With `"auto"`, sidebars and supported floating windows follow `transparent`:
they use their dark backgrounds by default and become transparent when it is
enabled. Set either style explicitly to `"dark"`, `"normal"` (the editor
background), or `"transparent"` to override that behavior. Completion menus,
selection highlights, and colored title labels retain their backgrounds for
readability.

When transparency is enabled, `colors.bg_base` and `colors.bg_dark_base`
retain solid colors for inverse text and terminal black. They can be changed
in `on_colors` independently of the transparent window backgrounds.

Disabling an integration only omits Stealth's definitions; it does not disable
the plugin or its own default highlights. The `lsp`, `semantic_tokens`, and
`treesitter` flags can be controlled independently. User `on_highlights`
overrides run after this filtering.

---

## 🎨 Palette

Stealth uses the monochrome palette by default. The previous `variant` option
no longer selects a palette and can be removed from existing configurations.

---

## 📊 Lualine Theme Integration

Simply specify `'stealth'` as your theme in Lualine:

```lua
require('lualine').setup({
    options = {
      theme = 'stealth',
      component_separators = '',
      section_separators = '',
    }
})
```

You can also pass the generated table directly with
`theme = require("stealth").lualine()`.

---

## 📄 License

[MIT License](LICENSE). Designed and built with ❤️ for Neovim users.
