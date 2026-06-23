---
name: take-notes
description: Capture notes into the gregOS vault. Use when asked to take a note,
log something, make a task, or write a plan. Explains where the vault is and
when to use a Log line vs a Task vs a Plan.
---

# Take notes (gregOS vault)

Write notes into my Obsidian vault, even when the session is inside another repo.
The vault is the source of truth for notes, tasks, and plans.

## Vault location

`/Users/gnfisher/Development/gnfisher/gregOS`

Top-level split:
- `Career/` — work (GitHub).
- `Personal/` — everything else.
- `Log.md`, `Parking Lot.md` — vault-wide capture at the root.

Each area may have its own `README.md`. Read the nearest one before creating or
changing notes in that area.

## Pick the right destination

The three things I mean most often:

| If I say...                | Write to                  | It is...                                          |
| -------------------------- | ------------------------- | ------------------------------------------------- |
| "make a note", "log this"  | `Log.md`                  | a one-line, append-only capture                   |
| "make a task"              | `Tasks/Task-<slug>.md`    | a resumable working doc for in-flight work        |
| "make a plan"              | the area's `Plans/` folder| the durable narrative for a real workstream       |

When unsure, default to a Log line. Promote upward only once the work is real.

## Log (`Log.md`)

Append-only and human-readable. Add under today's `## YYYY-MM-DD` heading. Short
bullets with stable prefixes:

- `note:` context worth remembering
- `issue:` something broken or confusing
- `meeting:` accepted/confirmed meetings only — `- meeting: 2:30 PM ET Sync on Automation`
- `decision:` lightweight decision not yet worth extracting
- `idea:` possible future direction
- `wait:` something that must resurface

## Task (`Tasks/`)

A lightweight artifact to return to after an interruption (context switch, end of
day). It captures the current theory, what's done vs incomplete, and what was left
in progress.

- File: `Tasks/Task-<descriptive-slug>.md`
- When finished: prefix the filename with `[CLOSED]-` or move it into `Tasks/Completed/`.

## Plan (area `Plans/` folder)

More than a task list — the durable story of a workstream: why it exists, current
understanding, agent plans, decisions, work log, validation, and follow-ups.

- Lives in the relevant area, e.g. `Career/GitHub/Copilot Agent Platform/Plans/`.
- File: `YYYY-MM-DD--Short-Title.md`.
- Start from that folder's `_Template.md`; keep sections short and delete what's irrelevant.

## Other places

- `Parking Lot.md` — loose someday/ideas not tied to active work.
- `TIL/` — one-off learnings (scripts, commands, how-tos) with links.
- `Architecture/` — durable explanations of how a system works.

## Guardrails

- Capture what will matter later, not everything.
- Prefer one evolving document per chunk of work over many fragmented notes.
- Don't over-structure during capture; a clean Log line beats a half-filled template.
- Read the nearest `README.md` (and `Plans/_Template.md`) before heavier writes.
