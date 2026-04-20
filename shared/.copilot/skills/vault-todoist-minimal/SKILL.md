---
name: vault-todoist-minimal
description: Minimal workflow for managing Log.md and Todoist. Focus on fast append-only notes, clear meeting lines, and daily shaping of only real commitments.
---

Use this skill for day-to-day note capture and Todoist triage in the vault.

## Vault location

- Primary vault path: `/Users/gnfisher/Development/gnfisher/gnfisher-gh-vault`
- Primary log file: `/Users/gnfisher/Development/gnfisher/gnfisher-gh-vault/Log.md`
- If working from another repository, use this vault path as the source of truth for notes/log updates.

## Scope

This skill is intentionally narrow:
- `Log.md` for working notes and context
- Todoist for commitments that must resurface

Skip heavier systems (project-note fan-out, broad automation, aggressive rewriting).

## Core rule

> Log for what happened and what mattered; Todoist for what must come back.

## Log.md rules

1. Keep `Log.md` append-only and human-readable.
2. Use the existing daily heading style already in the file.
3. Prefer short bullets with stable prefixes:
   - `note:`
   - `issue:`
   - `meeting:`
   - `decision:`
   - `idea:`
   - `wait:`
4. Only add meetings that are accepted/confirmed (not canceled/declined/new invite).
5. Meeting line format:
   - `- meeting: TIME ET Description`
   - Example: `- meeting: 2:30 PM ET Sync on Automation`

## Timestamp and formatting guidance

- Include timezone explicitly for meeting entries: `ET`.
- Keep titles concise and legible when seen cold.
- If adding links in notes, use standard Markdown links.
- Prefer one clean line over over-structured formatting.

## Todoist shaping rules

Promote to Todoist only when it is a durable commitment:
- promises made
- explicit asks
- blockers
- follow-ups
- deadlines
- waiting items that need resurfacing

Keep in `Log.md` if it is context, thinking, or non-committed idea.

For Todoist tasks:
1. Use verb-first titles.
2. Add enough context in description to survive cold.
3. Add source links when useful.
4. Add due dates only when date-based resurfacing matters.
5. Use recurring tasks for routines.
6. Add reminders only for real dated commitments.

## Daily shaping pass (once per day)

1. Review today's new log bullets.
2. Discard noise.
3. Promote only durable commitments to Todoist.
4. Tighten wording/context for clarity.
5. Keep list lean (remove fake urgency dates, merge duplicates).

## Guardrails

- Do not capture everything from Slack/email/GitHub.
- Do not create extra markdown backlogs by default.
- Do not force perfect organization during capture.
- Prefer low-friction consistency over ambitious process.
