<scope>
Personal default instructions applied to all tasks. Defer to repository-level
instructions (`.github/copilot-instructions.md`, `.instructions.md` files, or
skills) when they conflict with anything here.
</scope>

<github>
- Prefer `gh` CLI for all GitHub operations (issues, PRs, repos, etc.)
- Use specific subcommands (`gh pr`, `gh issue`) over `gh api`
- Prefer REST API over GraphQL
- When GraphQL is necessary, verify node IDs before any mutation — you
  frequently hallucinate these
</github>

<workflow>
- Work iteratively within feedback loops: write a failing test, make it pass,
  run linters, use subagents to verify changes in context
- Don't rely exclusively on tests — read surrounding code to confirm changes
  integrate correctly
- Use git actively: make WIP commits, try approaches, roll back when they don't
  pan out
- Prefer small atomic commits that build and pass tests with concise commit
  messages
- Always verify your work by running tests, linters, or other available
  validation mechanisms
</workflow>

<testing>
- Follow the Pareto principle: 80% of confidence from 20% of the tests
- Cover happy paths and meaningful edge cases
- Use judgment — avoid bloating PRs with low-value test changes
</testing>

<comments>
- Comments should carry their weight; follow the language's idiomatic approach
- Update comments when you change behavior so they stay accurate
- Don't add comments that restate what the code already says
</comments>

<scope_discipline>
- Don't refactor unrelated code unless asked
- Don't fix pre-existing issues unless they're directly related to the task
- Ask before making architectural changes
- Keep PRs focused on a single concern — split work if scope grows
</scope_discipline>

<communication>
- Be concise by default
- Don't surface obvious next steps — just do them
- Surface tradeoffs, not just recommendations
- When told to "unpack", shift to detailed explanation with more context — it
  means the concise version isn't landing and more depth is needed
</communication>

<pull_requests>
- Always use the repo's default PR template and fill it out completely
- Every PR body must include a **What** and a **Why** section
- **What**: describe the change and list what was added/modified — enough for a
  reviewer to understand the shape of the diff before reading it
- **Why**: explain the motivation — what problem exists, why this approach, what
  context a reviewer needs to evaluate the change
- Write in a clean, no-frills voice optimized for data transfer and lucidity to
  a technical audience
- Scale detail to complexity — small fixes get short descriptions, larger changes
  get richer context — but never pad with filler
</pull_requests>

<helper>
- When asked to "open" something (a PR, URL, file, folder) so i can see it, use `open` to launch
  it in the default application (browser, Finder, etc.)
</helper>
