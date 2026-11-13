# 🥷 stealth.nvim

An ultra-minimalist, matte-black, high-contrast Neovim colorscheme inspired by **Monkeytype's Stealth** theme.

Designed with precision for focus, clarity, and modern Neovim features. Personalized token styling for comments, keywords, functions, variables, strings, types, and rich integration with popular Neovim plugins.

---

## ✨ Features

- 🎯 **Monkeytype Stealth Aesthetic**: Deep matte-black backgrounds, crisp white accents, and slate grey secondary hierarchy.
- 🎨 **Multiple Palette Variants**: `stealth` (default), `monochrome`, `emerald`, `cyan`, `violet`, and `amber`.
- 💬 **Personalized Syntax Highlights**: Customize styles (`italic`, `bold`, `undercurl`) for comments, keywords, functions, variables, constants, and types.
- 🪟 **Transparent Mode**: Toggle transparent background for floating windows, sidebars, or the entire editor.
- ⚡ **Full Plugin Ecosystem Integration**:
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
  - Noice.nvim / nvim-notify
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
  opts = {
    variant = "stealth",
    styles = {
      comments = { italic = true },
      keywords = { bold = true },
    },
  },
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
  -- Palette variant: "stealth" (default), "monochrome", "emerald", "cyan", "violet", "amber"
  variant = "stealth",

  -- Enable transparent background
  transparent = false,

  -- Dim background of inactive windows
  dim_inactive = false,

  -- Set terminal colors (vim.g.terminal_color_*)
  terminal_colors = true,

  -- Personalized syntax styles
  styles = {
    comments = { italic = true },
    keywords = { bold = true, italic = false },
    functions = { bold = false, italic = false },
    variables = { italic = false },
    parameters = { italic = true },
    strings = { italic = false },
    constants = { bold = true },
    types = { bold = false },
    sidebars = "auto", -- "auto", "dark", "transparent", or "normal"
    floats = "auto",   -- "auto", "dark", "transparent", or "normal"
  },

  -- Set an integration to false to omit Stealth's highlight definitions
  plugins = {
    telescope = true, nvimtree = true, neotree = true, whichkey = true,
    gitsigns = true, cmp = true, blink = true, indent_blankline = true,
    mini = true, trouble = true, dashboard = true, alpha = true,
    noice = true, notify = true, treesitter = true, lsp = true,
    semantic_tokens = true,
  },

  -- Override colors
  on_colors = function(colors)
    colors.comment = "#6b7280" -- Customize comment color
    colors.accent = "#818cf8"  -- Customize accent
  end,

  -- Override highlight groups
  on_highlights = function(highlights, colors)
    highlights.Comment = { fg = colors.comment, italic = true }
    highlights.Function = { fg = colors.green, bold = true }
  end,
})

vim.cmd.colorscheme("stealth")
```

With `"auto"`, sidebars and supported floating windows follow `transparent`:
they use their dark backgrounds by default and become transparent when it is
enabled. Set either style explicitly to `"dark"`, `"normal"` (the editor
background), or `"transparent"` to override that behavior. Completion menus,
selection highlights, and colored title labels retain their backgrounds for
readability.

Disabling an integration only omits Stealth's definitions; it does not disable
the plugin or its own default highlights. The `lsp`, `semantic_tokens`, and
`treesitter` flags can be controlled independently. User `on_highlights`
overrides run after this filtering.

---

## 🎨 Palette Variants

| Variant | Accent / Key Features |
| :--- | :--- |
| `stealth` (Default) | Iconic Monkeytype white main accent, emerald mint functions, sky cyan types, slate comments. |
| `monochrome` | Neutral black, grey, and white UI, syntax, and Git colors, with red errors. |
| `emerald` | Stealth dark background paired with vibrant emerald mint accents. |
| `cyan` | Cool arctic cyan and sky blue accents on matte black background. |
| `violet` | Elegant lavender and violet accents for a dark cyberpunk vibe. |
| `amber` | Tactical golden amber accents on matte black background. |

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
