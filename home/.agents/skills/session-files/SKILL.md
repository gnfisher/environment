---
name: session-files
description: "Use the coding agents' persistent vault at ~/.local/Agent/ for session scratch, intermediate artifacts, durable knowledge, prior work, people and expertise, recurring issues, GitHub procedures, explicit remember or recall requests, and nightly knowledge curation."
---

# Session files

`~/.local/Agent/` is the agents' persistent working memory and default
workspace for files created during a session. It supports Markdown, Obsidian
links, and Mermaid.

Use it instead of client-specific locations such as
`~/.copilot/session-state/<session-id>/files/` for agent-created scratch,
downloaded evidence, drafts, and intermediate artifacts. Do not move or modify
client-managed databases, transcripts, checkpoints, or files a tool requires in
its own directory.

## Content types

Keep temporary workspace separate from durable knowledge:

```text
~/.local/Agent/
  sessions/       per-session scratch and intermediate artifacts
  shared/         artifacts intended for the user
  ...             durable notes and indexes
```

Session files may be incomplete and temporary. Durable notes should synthesize
reusable understanding about projects, workstreams, people and expertise,
decisions, recurring issues, repository or service relationships, and GitHub
procedures.

Treat durable notes as leads, not authority. Verify them against current sources
before acting, and correct or supersede stale knowledge.

## Session workspace

When a task needs files outside the repository, create:

```text
sessions/YYYY-MM-DD/<client>-<session-id-or-time>-<short-topic>/
```

Use the real client session ID when available; otherwise use a local `HHMMSS`
timestamp. Add a `_session.md` manifest with known context:

```markdown
---
kind: session
status: active
created: 2026-08-25T14:30:00-04:00
updated: 2026-08-25T14:30:00-04:00
client: opencode
agent: build
model: github-copilot/gpt-5.6-sol
session_id: ses_example
cwd: ~/Development/github/sweagentd
repos: [github/sweagentd]
topics: [runtime]
---

# Runtime investigation

## Goal
## Working context
## Artifacts
## Durable knowledge candidates
```

Record real values when known and omit unavailable fields. Add a parent session
or agent identifier when it helps trace delegated work.

Capture lightly during the task. Avoid concurrent edits to the same note or
index. Promote reusable findings from session scratch into durable notes rather
than treating raw scratch as verified knowledge.

## Search and capture

Search when a task refers to prior work, resumes a workstream, needs ownership
or expertise, encounters a familiar issue, or requires GitHub navigation or a
known procedure. Search by likely people, project, repository, system, decision,
error, and procedure terms. Follow relevant links without turning a focused task
into an unbounded vault review.

Capture context that can prevent repeated explanation or investigation. Do not
promote routine activity logs, transient status, speculation, or facts already
clear in an authoritative source. Never store credentials, tokens, customer
data, or unnecessary sensitive information.

## Searchable durable notes

Search for an existing note before creating one. Use descriptive kebab-case
filenames based on the subject, not the originating session. Include exact terms
someone might search for: `owner/repo`, product names, acronyms and expansions,
error signatures, issue or PR numbers, and established names or handles.

Use this vocabulary consistently. Include only fields that help retrieval or
freshness:

```yaml
---
kind: project | workstream | person | decision | issue | procedure | reference
title: Descriptive title
status: active | uncertain | superseded | archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
topics: []
aliases: []
repos: []
people: []
source_sessions: []
---
```

Write important identifiers in the body as well as frontmatter so ordinary text
search can find them. Start with an exact `#` title. Use these headings when they
fit, and omit empty sections:

- `## Summary`
- `## Facts`
- `## Decisions`
- `## Open questions`
- `## Sources`
- `## Related`

State uncertainty explicitly. Include dates and source commits, versions,
branches, links, or environments when they affect freshness. Link related notes
and create indexes when doing so provides a useful entry point.

## Maintenance

During an explicit maintenance run:

- Promote useful findings from recent session workspaces.
- Consolidate duplicates and cross-link related knowledge.
- Update useful indexes and reconcile conflicting claims when evidence exists.
- Mark stale notes as uncertain, superseded, or archived.
- Surface unresolved questions and possible future work without presenting them
  as commitments.
- Remove or archive scratch only after useful material has been promoted and it
  no longer supports active work.

Improve retrieval incrementally; do not reorganize the vault merely to impose a
taxonomy.

## Sharing

Put artifacts intended for the user in `~/.local/Agent/shared/` and
provide the exact path. Everything else is private agent working memory.
