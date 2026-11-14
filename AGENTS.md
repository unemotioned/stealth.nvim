# Repository guidance

## Verification
- Run the smoke test from the repository root (requires Neovim, not standalone Lua):
  ```sh
  nvim --headless -u NONE -i NONE --cmd 'set runtimepath+=.' -l tests/test_colorscheme.lua
  ```
- This single script covers the monochrome palette, customization hooks, and the Lualine table; no plugin installation is needed. There is no configured build, lint, formatter, or separate test runner.

## Runtime gotchas
- Default options are initialized when the configuration module loads, so `:colorscheme stealth` works without `setup()`. Each `setup()` merges against defaults, not previous options, and does not apply highlights.
- The load pipeline is palette/transparency → `on_colors` → highlight table → `on_highlights` → `nvim_set_hl` → optional terminal colors. Keep user hooks after built-in overrides. `colors()` and `highlights()` regenerate tables and rerun the relevant hooks.
- Theme-defined highlights and Lualine styles are neither bold nor italic by default. Preserve explicit syntax style and `on_highlights` opt-ins.
- Plugin highlights live in the single table in `lua/stealth/highlights.lua`. The `plugins` flags omit Stealth's definitions, not a plugin's own defaults; filtering runs before `on_highlights`.
- Sidebar and float styles default to `"auto"`, which follows global `transparent`. Explicit `"dark"`, `"normal"`, and `"transparent"` styles override that behavior; completion menus and colored title labels retain their backgrounds.
- Lualine is available through `require("stealth").lualine()` and the `lua/lualine/themes/stealth.lua` discovery module. Lualine style attributes use `gui`, not Neovim's `bold` boolean.
