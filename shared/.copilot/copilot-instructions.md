# Scope
- These are my personal default instructions.
- Follow repository-level instructions when they conflict with anything here.

# Comments
- Prefer the language's idiomatic commenting style.
- Update comments when behavior changes so they stay accurate.
- Avoid comments that only restate the code.

# Local behavior
- If I ask you to "open" a PR, URL, file, or folder so I can view it, use the platform-native opener: `open` on macOS, `start` on Windows, and `xdg-open` on Linux.

# Copilot worktrees
- When creating a local worktree for a Copilot session, create it under `~/.copilot/copilot-worktrees`.
- Resolve the source repo from `~/Development/<owner>/<repo>` when possible, but keep the worktree checkout itself under the Copilot worktree base directory.
- Match the existing layout: use `~/.copilot/copilot-worktrees/<repo>/pr-<number>` for PR sessions, and `~/.copilot/copilot-worktrees/<repo>/<user>/<session-slug>` for other named sessions.
- Treat `pr-<number>` and `<user>/<session-slug>` as the worktree directory naming convention, not as a required Git branch naming convention. The checked-out branch may differ from the directory name.
- Prefer reusing an existing matching worktree over creating a duplicate with a different path.

# Collaboration
- For non-trivial coding work, prefer an independent critique at high-leverage moments.
- If the current session model is in the Claude family, rely on the built-in rubber-duck flow.
- Otherwise, when a deep independent critique is worthwhile, use the `/critique-loop` skill or invoke the local `copilot-critic` wrapper instead of the bare `critic` agent so the model and reasoning effort are explicit. The equivalent direct command is `copilot --agent critic --model gpt-5.4 --effort high`.
- Use that extra pass before implementation, after substantial changes, and before wrapping up.
- Skip extra critique for small, mechanical, or low-risk tasks.

# User the GitHub CLI!
- Prefer `gh` over MCP for GitHub operations when `gh` can handle the task cleanly.
- Prefer purpose-built subcommands like `gh pr` and `gh issue` over `gh api`.
- Prefer REST endpoints to GraphQL unless GraphQL is clearly the better fit.
- If you use a GraphQL mutation, verify that the node IDs match the intended resources before mutating anything. Agents frequently hallucinate node IDs, and mutating the wrong resource can have serious consequences, including leaking privileged information in public places.
