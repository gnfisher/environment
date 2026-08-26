---
name: local-repos
description: "Locate, choose, open, or clone repositories and worktrees under ~/Development, including resolving project names and nicknames to canonical GitHub repositories."
---

# Local repositories

Repositories are checked out under:

```text
~/Development/<owner>/<repo>
```

Treat `~/Development/github/*` as the local collection of GitHub-owned
repositories. Before cloning, check for the canonical checkout there. Clone a
missing repository into its owner directory:

```bash
gh repo clone <owner>/<repo> ~/Development/<owner>/<repo>
```

Directories such as `<repo>.worktrees/` and `<repo>-<topic>/` may be worktrees
or task-specific checkouts. They do not replace the canonical checkout. Inspect
their Git metadata when the distinction matters.

## Managed worktrees

Use `ws` instead of raw `git worktree` commands to create, find, switch between,
list, or remove managed worktrees. Run `ws --help` for the current interface.

`ws new`, `ws pr`, `ws open`, and `ws pick` print an absolute path; they do not
change the caller's working directory. Wrap them with `cd` when switching:

```bash
cd "$(ws new <session-slug>)"
cd "$(ws pr <number-or-url>)"
cd "$(ws open <name-or-path>)"
cd "$(ws pick)"
ws list
ws list --all
```

Use `ws delete <name-or-path>` to remove a managed worktree only when the user
explicitly requests removal. `ws dd` removes the current worktree and prints the
base repository path; treat it as destructive.

## Project index

| Name | Repository | Meaning |
| --- | --- | --- |
| CMC, mission control | `github/copilot-mission-control` | Copilot Mission Control |
| copilotd | `github/copilot-host` | Copilot host |
| supervisor | `github/copilot-agent-supervisor` | Copilot agent supervisor |

CCA, or Copilot Coding Agent, spans several repositories:

| Task area | Repository |
| --- | --- |
| Service and coding-agent execution | `github/sweagentd` |
| Web UI | `github/github-ui` |
| API and github.com monolith behavior | `github/github` |

Inspect each relevant repository for cross-component work. If the component is
unclear and the choice affects the work, ask one short clarifying question.

When another stable project nickname or component-to-repository mapping is
discovered, proactively add it to this index. Keep evolving or uncertain
relationships in the agent knowledge vault until they are verified.
