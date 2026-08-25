---
name: pr-descriptions
description: Write or revise a pull request description for an audience of reviewing peers. Use when opening a PR, editing a PR body, or when a PR description reads like a planning document.
---

# Writing PR descriptions

A PR description is written for peers who have not read your planning documents
and do not care how you arrived at your decisions. They want to know what the
change does, why it is worth making, how to read the diff, and what is
unaddressed, if anything.

## The failure mode

By the time you open a PR you are carrying every tradeoff you weighed and every
objection you answered. Dumping that into the body produces a description that
*argues* instead of *describes*. It reads as a defense of decisions written for
someone who was in the room.

The tell: paragraphs that justify a choice, recount what you considered, or
narrate your process. Also section titles like "Design notes," "Review notes,"
"Why this approach," and testing methodology written out in full.

That material is usually worth keeping. It just belongs somewhere else.

## Answer four questions, in this order

**1. What changed?** Describe the state of the world before, then what replaced
it. The "before" is what makes the change legible; without it a reviewer has to
infer the problem from the solution.

**2. Why does it matter?** See below. This is the section most often missing or
misaimed.

**3. How do I read the diff?** For a multi-commit PR, a table mapping SHA to
one-line purpose beats a narrative walkthrough. If each commit builds and passes
tests standalone, say so once, because it tells a reviewer they can go
commit-by-commit.

**4. What is still broken?** Name what the PR does not do, and call out anything
that blocks production or shipping. Be direct about it. A reviewer who discovers
a gap on their own trusts the rest of the description less.

## Motivation points forward, not backward

This is the sharpest and most commonly inverted rule.

Motivation is not the reasoning that led you to the change. It is what the
change makes possible. Concretely, name:

- the work it unblocks, with issue links,
- the code it lets you delete,
- the class of bug it now prevents.

> Backward (weak): "The existing abstraction conflated two concepts, so I
> introduced a value object to separate them."
>
> Forward (strong): "1P Agentic Apps (#13891) want an org actor and org billing.
> An app is not a user, so it has no user ID to supply. This also lets us delete
> the temporary bridge CCR shipped, and makes the next user-only call a compile
> error rather than a wrong answer at runtime."

The first tells a reviewer about your thinking. The second tells them why the
team should care, and it is checkable against issues that exist.

## Route prose to where it survives

Each destination has a different lifetime and a different reader. Choosing wrong
is why good analysis disappears.

| Destination | Holds | Lifetime |
|---|---|---|
| Commit message | Why *this* change is shaped this way | Permanent, attached to the code |
| PR body | What, why it matters, how to read, what is missing | Archaeology once merged |
| Docs in-repo | What a future reader needs who never saw the PR | Permanent and discoverable |
| Issue | Work that must outlive this PR | Permanent and trackable |

Two consequences worth internalizing:

- **Rationale goes in commit messages.** That is where a reader hits it via
  `git blame` on the line that confuses them, which is exactly when they need
  it. Moving rationale out of the PR body is not deletion.
- **A hazard documented only in a PR body is undocumented.** If a follow-up must
  happen, or a subtle constraint must hold, file the issue or write the doc.
  Check this deliberately before merging.

## Keep the one distinction that makes scope legible

Cut aggressively, with one exception: if a reviewer would otherwise think the
diff is arbitrarily scoped, one sentence explaining the boundary earns its
place.

> "Job counts and cache keys only need an opaque ID and were already correct.
> Only the paths that resolve identity against a user-shaped service were
> broken."

Without that, "why did you change these five call sites and not those twenty?"
becomes a review comment.

## Length

No word target. Every paragraph earns its place by answering a question a
reviewer actually has.

One useful signal: if your PR body is substantially longer than your longest
commit message, rationale is probably in the wrong place.

## Self-check before posting

- Would a peer who never saw your plan know why this exists, and what it
  unblocks?
- Is any paragraph arguing rather than describing? Move it to a commit message
  or cut it.
- Does anything in the body need to survive the merge? Put it in a doc or an
  issue.
- Does the reader know what is still broken, and what blocks production?
- Are your issue links and claims about other PRs still true? Merged
  dependencies silently invalidate "deferred to avoid a conflict with #NNNN"
  and similar.
- Preserve any repo PR template checklist verbatim.
