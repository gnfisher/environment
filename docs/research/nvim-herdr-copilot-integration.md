# Neovim to Herdr Copilot integration research

## Goal

Send an exact Neovim selection plus a prompt to a GitHub Copilot CLI agent in
the same Herdr workspace, without changing terminal focus. Support both normal
main-thread prompts and disposable side questions.

## Relevant existing behavior

- Herdr exposes the caller's workspace and tab through `HERDR_WORKSPACE_ID` and
  `HERDR_TAB_ID`. `herdr agent list` returns JSON containing each recognized
  agent's type, pane, tab, workspace, state, and native Copilot session ID.
- `herdr agent prompt <target> <text>` accepts either a unique agent name or the
  pane ID hosting an agent. It submits the prompt atomically using the target
  terminal's bracketed-paste mode, so a Neovim integration does not need to
  emulate terminal input.
- Copilot CLI provides `/ask` for a quick side question that is not added to the
  main conversation history. `/fork` creates an inherited session branch, but
  coordinating that branch in another pane introduces session and lifecycle
  management beyond a small first version.

Sources:

- [Herdr CLI reference](https://herdr.dev/docs/cli-reference/)
- The installed Herdr 0.7.5 `herdr agent` help
- The installed Copilot CLI 1.0.79 `/help` output
- [GitHub Copilot CLI documentation](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-copilot-cli)

## Neovim patterns worth reusing

[`copilot-cli.nvim`](https://github.com/KostkaBrukowa/copilot-cli.nvim) is the
closest existing plugin:

- Its `api.lua` captures characterwise, linewise, and blockwise visual
  selections with `vim.fn.getregion`, then collects a prompt with
  `vim.ui.input`.
- Its `terminal.lua` sends multiline text with bracketed-paste sequences. Herdr
  makes this transport layer unnecessary because `herdr agent prompt` already
  handles atomic terminal submission.
- It keeps command registration in `plugin/` and implementation under `lua/`,
  which makes the code straightforward to extract as a standalone plugin.

[`nvim-aider`](https://github.com/GeorgesAlkhouri/nvim-aider) uses the same
selection and API separation patterns, providing an independent example of the
approach.

Neovim APIs:

- [`vim.fn.getregion`](https://neovim.io/doc/user/builtin.html#getregion())
- [`vim.ui.input` and `vim.ui.select`](https://neovim.io/doc/user/lua.html#vim.ui)
- [`vim.system`](https://neovim.io/doc/user/lua.html#vim.system())

## Recommended first-version design

Keep the bridge self-contained under the future plugin namespace:

```text
lua/herdr_copilot/
  init.lua       Public send/ask functions and setup
  context.lua    Selection capture and prompt formatting
  herdr.lua      Agent discovery and async Herdr command execution
plugin/
  herdr_copilot.lua
```

The `plugin/` file should only register commands. Dotfile-specific keymaps stay
in the existing `plugin/keymaps.lua`, so extracting the module later only
requires moving the namespace and command loader.

### Agent selection

1. Refuse to run unless `HERDR_ENV=1` and `herdr` is executable.
2. Run `herdr agent list` asynchronously with `vim.system`.
3. Decode the JSON and retain Copilot agents whose `workspace_id` equals
   `HERDR_WORKSPACE_ID`.
4. Prefer a single agent in `HERDR_TAB_ID`.
5. If the result is ambiguous, use `vim.ui.select` with the terminal title,
   status, tab ID, and pane ID.
6. Cache the selected pane ID per workspace and invalidate it if prompt
   submission fails or the pane disappears.

Pane IDs are a better first-version target than agent names because recognized
Copilot agents are not always explicitly named.

### Prompt construction

Capture the visual selection exactly, including unsaved buffer contents, and
add source metadata. The generated prompt should have this shape:

    <user request>

    Context: path/to/file.go:42-57
    ```go
    <selected text>
    ```

Pass arguments to `vim.system` as an argv list rather than constructing a shell
command. This preserves newlines and quotes and avoids shell injection.

For a main-thread request, submit the formatted prompt unchanged. For a side
question, prefix the prompt with `/ask `. Do not use `--wait` in the initial
version; submission should be asynchronous and should never focus the target
pane.

### Commands and mappings

Expose two scriptable commands:

- `:HerdrCopilotSend` - send to the main conversation
- `:HerdrCopilotAsk` - send as a disposable `/ask` side question

Suggested visual mappings in the existing Copilot-oriented `<leader>c`
namespace:

- `<leader>cs` - send selection
- `<leader>cq` - ask a side question

## Deferred work

A true forked side session should be a later feature. It would need to:

1. Read the main agent's native Copilot session ID from Herdr.
2. Create a sibling pane without focus.
3. Safely create a Copilot `/fork` from the inherited history.
4. Name, track, and eventually close or retain that branch.
5. Avoid concurrent mutation of the main session while establishing the fork.

The `/ask` path supplies the useful temporary-side-question behavior without
those lifecycle risks.

## Validation cases

- No Herdr environment, no Herdr binary, and no Copilot agent in the workspace.
- One same-tab agent, one workspace-only agent, and multiple ambiguous agents.
- Characterwise, linewise, blockwise, reversed, and multiline selections.
- Unsaved buffer text and paths or prompts containing spaces and quotes.
- Main prompts versus `/ask` prompts.
- Busy, closed, or stale target panes.
- Confirm that submission does not change Herdr focus.
