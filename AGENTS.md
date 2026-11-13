# Repository guidance

## Verification
- Run the smoke test from the repository root (requires Neovim, not standalone Lua):
  ```sh
  nvim --headless -u NONE -i NONE --cmd 'set runtimepath+=.' -l tests/test_colorscheme.lua
  ```
- This single script covers all six variants, customization hooks, and the Lualine table; no plugin installation is needed. There is no configured build, lint, formatter, or separate test runner.

## Runtime gotchas
- Default options are initialized when the configuration module loads, so `:colorscheme stealth` works without `setup()`. Each `setup()` merges against defaults, not previous options, and does not apply highlights.
- The load pipeline is palette/variant/transparency → `on_colors` → highlight table → `on_highlights` → `nvim_set_hl` → optional terminal colors. Keep user hooks after built-in overrides. `colors()` and `highlights()` regenerate tables and rerun the relevant hooks.
- Plugin highlights live in the single table in `lua/stealth/highlights.lua`. The `plugins` flags in `config.lua` are currently unused; do not assume setting one to `false` disables an integration.
- Global `transparent` leaves `bg_float` opaque; floating-window transparency is controlled separately by `styles.floats`. Sidebar/float handling only distinguishes `"transparent"` from other values; `"normal"` currently behaves like `"dark"`.
- Lualine is exposed as `require("stealth").lualine()` (returns the theme table). Despite the README/help examples, there is no `lua/lualine/themes/stealth.lua` discovery module for `theme = "stealth"`; the smoke test checks only the table-returning API.
