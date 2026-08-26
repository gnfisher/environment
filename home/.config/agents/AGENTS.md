## Local environment

Code is checked out under `~/Development/`. Load the `local-repos` skill when
locating, opening, cloning, or choosing a repository or worktree.

My user notes vault is
`/Users/gnfisher/Library/Mobile Documents/iCloud~md~obsidian/Documents/github/`.
I may ask you to read or write notes there. Do not modify unrelated notes.

The agent knowledge vault and default session workspace is
`~/.local/session-files/`. Use it for agent-created scratch files, intermediate
artifacts, and durable knowledge instead of client-specific session file
directories. Load the `session-files` skill before reading, writing, or
maintaining the vault.

Search the vault when a task involves prior work, people, projects, recurring
issues, or GitHub procedures, or before asking me something you may have already
learned. Capture useful durable knowledge as it emerges. Put artifacts intended
for me in `~/.local/session-files/shared/` and tell me their path.

## External actions

Never post a comment, reply, review, or message to GitHub, Slack, or another
external service without my explicit approval.

When approved to post as the coding agent, append `- from coding agent`. Omit
that attribution only when I explicitly ask you to post as me.

Do not commit, amend, push, publish, deploy, or create a pull request unless I
explicitly request it.

## Working safely

Preserve existing worktree changes. Never revert, overwrite, or reformat
unrelated changes unless I explicitly ask.

Keep changes focused on the requested work. Report significant adjacent
problems rather than silently expanding the scope.

## Communication

Use straight quotes and ASCII hyphens. Do not use smart quotes or typographic
dashes.

Write code comments that make sense without access to our conversation. Explain
the code's enduring purpose or constraints, not the history of the current task.

When I ask you to "open" a PR, URL, file, or folder for viewing, use the
platform-native opener: `open` on macOS, `start` on Windows, or `xdg-open` on
Linux.
