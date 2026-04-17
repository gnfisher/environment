---
name: lint-fix
description: Run the current repository's existing lint workflow, fix error-level failures, and ignore warnings unless they block the fix.
---

Use this skill when you want Copilot to run a repository's real lint command and
address the resulting errors without turning the task into a broad cleanup pass.

## Goal

- Discover the project's intended lint entrypoint
- Run it
- Fix error-level failures
- Ignore warnings and non-blocking suggestions

## Preferred behavior

1. Prefer the repo's own lint wrapper first:
   - `make lint`
   - `just lint`
   - `task lint`
   - repo-local lint scripts
2. Fall back to language/package-manager lint commands only when the repository
   clearly uses them.
3. Re-run the same lint command after fixes.
4. Keep edits narrow and project-native.
5. When editing Go, use idiomatic Go and existing repo patterns.

## Guardrails

- Do not add new lint tooling or config.
- Do not fix warnings just because they exist.
- Do not turn lint cleanup into a broad refactor.
- If no credible lint command exists, stop and explain what was checked.

## CLI entrypoint

For a direct one-shot run from the terminal, use the custom agent:

```bash
copilot --agent lint-fix --allow-all-tools --no-ask-user -p "Run this project's linter and fix the errors."
```
