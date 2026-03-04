# LazyVim Configuration

This is a customized LazyVim configuration tailored to your preferences from your existing nvim setup.

## Features

### What's Included
- **Project Management**: `project.nvim` for automatic project detection, `persistence.nvim` for session management
- **Git Integration**: `fugitive`, `diffview`, and `gitsigns` for comprehensive git workflow
- **Fast LSP**: Optimized LSP configuration with `blink.cmp` (Rust-based, faster than nvim-cmp)
- **Formatting**: `conform.nvim` (faster than none-ls) with smart prettier detection
- **Telescope**: Enhanced with fzf-native, undo, and git-file-history extensions
- **Oil.nvim**: Your preferred buffer-based file explorer
- **Todo Comments**: Highlight and navigate TODO/FIXME/etc comments
- **Trouble**: Better diagnostics UI
- **Spectre**: Project-wide search and replace
- **Zen Mode**: Distraction-free writing

### What's Disabled (LazyVim bloat)
- Dashboard/alpha (no start screen)
- neo-tree (using oil.nvim)
- nvim-cmp (using blink.cmp)
- which-key (you know your bindings)
- noice.nvim (too intrusive)
- mini.nvim suite (preferring individual plugins)
- flash.nvim (no fancy motions)
- indent-blankline (cleaner look)
- bufferline (custom tabline)

## Performance Optimizations

### LSP Performance
- Disabled inlay hints (major performance win)
- Disabled `update_in_insert` for diagnostics
- Reduced `gopls` analyses (using golangci_lint_ls instead)
- Optimized `updatetime` (250ms)

### Startup Performance
- Disabled built-in vim plugins (gzip, netrw, etc)
- Lazy loading where appropriate
- Fast Rust-based tools (blink.cmp, telescope-fzf-native)

### Formatting Performance
- Using `conform.nvim` instead of `none-ls` (faster)
- Conditional prettier formatting (only when config exists)
- 500ms timeout to prevent blocking

## Key Mappings

### Your Custom Mappings (preserved)
- `<Space>` - Leader key
- `<C-Space>` - Clear search / Escape (in insert/visual)
- `<Leader>y` / `<Leader>Y` - Yank to clipboard
- `<Leader>p` - Paste without yanking
- `J` / `K` (visual) - Move lines up/down
- `]q` / `[q` - Next/prev quickfix
- `<F6>` - Toggle light/dark theme
- `<F12>` / `<S-F12>` - Go to definition / references
- `<F2>` - Rename
- `<F3>` - Format
- `-` - Open oil.nvim
- `<Space>-` - Open oil.nvim (float)

### New Mappings (from LazyVim + custom)
- `<Leader>fp` - Find projects (project.nvim)
- `<Leader>qs` - Restore session
- `<Leader>ql` - Restore last session
- `<Leader>qd` - Don't save current session
- `]h` / `[h` - Next/prev git hunk
- `<Leader>hs` - Stage hunk
- `<Leader>hr` - Reset hunk
- `<Leader>hp` - Preview hunk
- `<Leader>hb` - Blame line
- `<Leader>tb` - Toggle line blame
- `]t` / `[t` - Next/prev todo comment
- `<Leader>ft` - Find todos
- `<Leader>xx` - Toggle diagnostics (Trouble)
- `<Leader>sr` - Search and replace (Spectre)
- `<Leader>z` - Zen mode

## Usage

### Switching to This Config

1. **Backup your current config**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Symlink or copy this config**:
   ```bash
   ln -s ~/environment/shared/.config/nvim-lazyvim ~/.config/nvim
   # OR
   cp -r ~/environment/shared/.config/nvim-lazyvim ~/.config/nvim
   ```

3. **Start nvim and let it install**:
   ```bash
   nvim
   ```

4. **Install LSP servers**:
   ```vim
   :Mason
   ```

### Switching Back

```bash
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim
```

## Troubleshooting

### LSP Still Slow?

1. **Check antivirus**: Disable it temporarily to test if it's the culprit
2. **Reduce LSP servers**: Comment out `golangci_lint_ls` in `lua/plugins/lsp.lua`
3. **Increase updatetime**: Change `vim.opt.updatetime = 500` in `lua/config/options.lua`
4. **Check LSP logs**: `:LspLog`

### Missing Plugins?

Run `:Lazy sync` to update all plugins.

### Format Not Working?

- For prettier: Ensure `.prettierrc` or similar config exists in your project
- For Go: Ensure `gofmt` and `goimports` are installed via `:Mason`
- Check `:ConformInfo` for formatter status

## Customization

### Adding Plugins

Create a new file in `lua/plugins/your-plugin.lua`:

```lua
return {
  {
    "author/plugin-name",
    opts = {
      -- your config
    },
  },
}
```

### Disabling More Plugins

Add to `lua/plugins/disabled.lua`:

```lua
{ "plugin-name", enabled = false },
```

### Changing Keymaps

Edit `lua/config/keymaps.lua` or add to plugin configs.

## Philosophy

This config maintains your preferences:
- **Fast and responsive** - No bloat, optimized for performance
- **Minimal UI** - Clean, distraction-free interface
- **Manual control** - No auto-complete/format surprises
- **Light theme** - Default to zellner, easy toggle to dark
- **Simple plugins** - Each plugin serves a clear purpose

Enjoy your new LazyVim setup! 🚀
