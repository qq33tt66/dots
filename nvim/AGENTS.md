# AGENTS.md — Neovim Configuration

This is a personal Neovim configuration using `vim.pack` (Neovim's built-in package manager,
requires Neovim 0.11+). There is no external plugin manager (no lazy.nvim, packer, etc.).

## Project Layout

```
init.lua                  ← Entry point: vim.pack.add() then require() each module
nvim-pack-lock.json       ← Pinned plugin revisions (managed by vim.pack)
snippets/
  cpp.json                ← VSCode-format C++ snippets for competitive programming
lua/
  core/                   ← Editor behaviour: options, keymaps, autocmds, utilities
    autocmds.lua
    keymaps.lua
    loader.lua
    minifilesgit.lua      ← Git signs in mini.files explorer (M-module pattern)
    options.lua
    utils.lua
  plugins/                ← One file per plugin (or plugin group); calls .setup()
    completion.lua
    conform.lua
    mason.lua
    mini.lua
    miniclue.lua
    telescope.lua
    toggleterm.lua
    treesitter.lua
    ui.lua
    ...
```

## Build / Lint / Test

There is **no build system, no linter config, and no test framework** in this repo.

| Task | How to do it |
|---|---|
| Validate config loads | Start Neovim: `nvim --headless -c 'quit'` (non-zero exit = error) |
| Check plugin health | `:checkhealth` inside Neovim |
| Reload a single module | `:luafile %` or `:source %` on the current file |
| Sync / update plugins | `:lua vim.pack.update()` inside Neovim |
| Clean orphaned plugins | `:lua require("core.utils").pack_clean()` |

There is no single-test command. Correctness is verified by loading the config in Neovim and
exercising the changed feature manually.

If you add a linter in future, `.stylua.toml` (StyLua) and `selene.toml` (Selene) are the
conventional Lua tooling choices for Neovim configs.

## Code Style

### Indentation and Formatting

- **No formatter is enforced** on the Lua sources themselves (conform.nvim only runs `prettier`
  for web filetypes). Match the indentation of the file you are editing.
- Existing files use **tabs** (`init.lua`, `keymaps.lua`, `competitest.lua`) or **2 spaces**
  (`options.lua`, `completion.lua`, `conform.lua`, `mini.lua`). New files should prefer **2
  spaces** to match the majority of plugin files.
- Quote style is inconsistent across the repo; prefer **double quotes** for new code.
- No trailing whitespace — an autocmd in `autocmds.lua` strips it on every save.

### Module Structure

**`lua/core/` files** — utility modules that expose an API — use the `M` table pattern:

```lua
local M = {}

function M.some_function()
  -- ...
end

return M
```

**`lua/plugins/` files** — simple setup scripts — are flat files with no module table:

```lua
require("some-plugin").setup({
  option = true,
})
```

### Imports / Requires

**Top-level requires** for modules whose API is used throughout the file:

```lua
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
require("telescope").setup({ ... })
```

**Inline lazy requires** inside keymap callbacks (defers loading until the key is pressed):

```lua
vim.keymap.set("n", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, { desc = "Search word under cursor" })
```

**Protected requires** for optional dependencies:

```lua
local _, MiniFiles = pcall(require, "mini.files")
```

Do not use `pcall(require, ...)` for modules that must be present; let the error surface.

### Neovim API Aliasing

In files that call `vim.api.*` or `vim.fn.*` heavily, alias at the top of the file:

```lua
local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local fn = vim.fn
```

Simple plugin setup files do not need aliasing — call `vim.api.*` directly.

### Naming Conventions

- **`snake_case`** for all variables, function names, and table keys.
- **Module tables** are always named `M`.
- **Local helper functions** use descriptive `snake_case` names:
  `minifiles_toggle`, `new_scratch_buffer`, `win_config`.
- **`camelCase`** should be avoided; it only appears in `minifilesgit.lua` which was adapted
  from an external source. Do not introduce new `camelCase` identifiers.
- Boolean options and guard variables follow the `is_` / `has_` prefix convention where it
  aids clarity (`is_symlink`).

### Keymaps

All keymaps must include a `desc` field:

```lua
vim.keymap.set("n", "<leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", {
  desc = "Code actions",
})
```

Use `noremap = true, silent = true` only where the default behaviour would cause problems.
Most simple `<Cmd>…<CR>` mappings do not need these flags.

### Error Handling

**Guard with early returns** rather than deep nesting:

```lua
local client = vim.lsp.get_client_by_id(args.data.client_id)
if not client then
  return
end
```

**`pcall` for calls that may fail** (cursor positioning, optional API methods):

```lua
pcall(api.nvim_win_set_cursor, winid, position)
pcall(vim.treesitter.start)
```

**Check preconditions before async work:**

```lua
local cwd = vim.uv.cwd()
if not cwd or not vim.fs.root(cwd, ".git") then
  return
end
```

Do not swallow errors silently unless the failure is genuinely expected and harmless.

### Type Annotations (LuaLS / EmmyLua)

Annotations are not required in simple setup files. For complex utility modules in `lua/core/`
that expose non-trivial functions, add LuaLS annotations on public functions:

```lua
---@param buf_id integer
---@param gitStatusMap table<string, string>
---@return nil
local function updateMiniWithGit(buf_id, gitStatusMap) ... end
```

There is currently no `.luarc.json`; if you add one, configure the Neovim runtime library path
so LuaLS can resolve `vim.*` globals.

### Adding a Plugin

1. Add a `vim.pack.add` entry in `init.lua` (keep the list alphabetical by plugin name if
   possible).
2. Create `lua/plugins/<name>.lua` with the setup call.
3. Add `require("plugins.<name>")` in `init.lua` after the `vim.pack.add` block.
4. Add keymaps in `lua/core/keymaps.lua` (not inside the plugin file).
5. Add autocommands in `lua/core/autocmds.lua` unless they are tightly coupled to the plugin's
   own setup (e.g., an `on_attach` callback inside `mason.lua`).

### Snippets

Snippets live in `snippets/` in VSCode JSON format. The C++ file (`cpp.json`) is loaded by
LuaSnip via `lua/plugins/snippet.lua` and also by `mini.snippets` in `lua/plugins/mini.lua`.
Global snippets go in `snippets/global.json`.
