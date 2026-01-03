# Neovim Configuration

This directory contains the Neovim configuration, structured for use with [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager.

## Directory Structure

```
nvim/
├── init.lua              # Entry point, bootstraps lazy.nvim
├── lazy-lock.json        # Plugin version lockfile
├── lua/
│   └── plugins/          # Plugin specs for lazy.nvim (each file returns a table)
│       └── theme.lua
├── plugin/               # Auto-loaded Lua files (vim options, keymaps, etc.)
│   ├── clipboard.lua
│   ├── colors.lua        # Colorscheme/theme activation
│   ├── format.lua
│   ├── keymaps.lua
│   ├── options.lua
│   ├── statusline.lua
│   ├── tabline.lua
│   └── terminal.lua
├── after/                # After-plugins configuration
└── colors/               # Custom colorschemes
```

## Key Conventions

### `lua/plugins/` - Plugin Specifications

Files in this directory are loaded by lazy.nvim. **Each file must return a table** (or a list of tables) defining plugin specs.

### `plugin/` - Auto-loaded Configuration

Files in `plugin/` are automatically sourced by Neovim after initialization. Use this for:
- Vim options (`options.lua`)
- Keymaps (`keymaps.lua`)
- Colorscheme activation (`colors.lua`)
- Custom statusline/tabline
- Any runtime configuration

## Things to Remember

1. **Files in `lua/plugins/` MUST return a table.** Do not write executable code after the `return` statement — it will cause errors or be ignored. If you need to run setup code (like setting a colorscheme), put it in a `config` function inside the plugin spec, or in a separate file under `plugin/`.

2. **Separate plugin specs from runtime config.** Plugin installation/configuration goes in `lua/plugins/`. Runtime settings (options, keymaps, colorscheme activation) go in `plugin/`.

3. **lazy.nvim expects specific table structure.** Each plugin spec should be `{ "author/plugin-name", ... }` with optional keys like `lazy`, `priority`, `config`, `dependencies`, etc.

4. **Use `plugin/colors.lua` for colorscheme activation.** This keeps theme selection separate from theme plugin installation.
