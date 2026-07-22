# Scope
- These are my personal default instructions.
- Follow repository-level instructions when they conflict with anything here.

# Comments
- Prefer the language's idiomatic commenting style.
- Update comments when behavior changes so they stay accurate.
- Avoid comments that only restate the code.

# Local behavior
- If I ask you to "open" a PR, URL, file, or folder so I can view it, use the platform-native opener: `open` on macOS, `start` on Windows, and `xdg-open` on Linux.
- If you are in a directory titled `pr-<numbers>` e.g. `pr-3468` you are in a a worktree for a PR and should be in a reviewer's mindset unless told othewise. Do not make code changes or push to the branch unless explicitly asked to.

# Copilot worktrees (only if running in GitHub CLI)
- Use my `ws` CLI tool for managing worktrees.
- When creating a local worktree for a Copilot session, create it under `~/.copilot/copilot-worktrees`.
- Resolve the source repo from `~/Development/<owner>/<repo>` when possible, but keep the worktree checkout itself under the Copilot worktree base directory.
- Match the existing layout: use `~/.copilot/copilot-worktrees/<repo>/pr-<number>` for PR sessions, and `~/.copilot/copilot-worktrees/<repo>/<user>/<session-slug>` for other named sessions.
- Treat `pr-<number>` and `<user>/<session-slug>` as the worktree directory naming convention, not as a required Git branch naming convention. The checked-out branch may differ from the directory name.
- Prefer reusing an existing matching worktree over creating a duplicate with a different path.

# Working in the repos I use
- I have all github repos checked out under `~/Development/<owner>/<repo>`.
- If you need to work with a repo, check if it's already checked out there before cloning.
- If the branch is clean in a repo, get on main/master and pull before starting work.
- When cloning a new repo, put it under `~/Development/<owner>/<repo>`, e.g. `gh repo clone <owner>/<repo> ~/Development/<owner>/<repo>`.

# Style
- Never use smart quotes or fancy hyphens. Use simple straight quotes and simple
  hyphens and dashes only, always, in all situations.

# Communication improvement notes
- When I correct unclear wording, ask what a phrase means, or have you rewrite
  something to make it more intelligible, append the example to
  `~/Development/agent-notes/examples.md`.
- Record the original context, my feedback, the clearer wording, and the
  general communication lesson that could improve future prompting.
- Prefer concrete names for the actual system entities involved over vague
  abstractions. If an abstraction is useful, define what it means in context.
