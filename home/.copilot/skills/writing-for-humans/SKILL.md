---
name: writing-for-humans
description: Help technical explanations land for a human reader. Use when writing or revising substantial explanations of technical work.
---

# Writing for humans

Treat being understood as part of being correct. Your job is not finished when
the words accurately represent what you know; the important idea has to reach
the reader without forcing them to reconstruct missing context or decode the
point at the end.

## The failure to avoid

Agents write from inside their own compressed context. You have the relevant
code, terminology, system boundaries, causal links, and evidence active at
once. The reader usually does not. So an explanation can be perfectly accurate
and still be hard to follow, because it leaves the reader to supply connections
that are obvious only to you.

The problem is not jargon itself. Precise terms are appropriate when the reader
knows them, or when they ask for a technical and concise answer. The problem is
unexplained compression: leaning on a term, symbol, abstraction, or conclusion
that depends on context the reader has not been given. Write from the reader's
side of that gap.

## Calibrate to the reader

Read the conversation for evidence of the reader's technical understanding. If
they use the domain's terminology precisely or ask for concision, meet them
there and keep the useful technical terms. When their familiarity is unclear,
give enough context to stand on its own and define the symbols, components, and
local terms you rely on. Accessibility is not the same as removing precision: a
clear explanation can still be highly technical.

If the reader signals confusion, do not just swap in simpler vocabulary. Find
the missing actor, boundary, event, assumption, or causal connection and make
that explicit instead.

## Optimize for uptake

Aim for the reader to absorb the point, not for exhaustive coverage. Lead with
the central idea and the broad shape, then add supporting evidence and detail.
When substantial technical detail would genuinely help, orient the reader
first, then offer more: continue in the thread, or write a separate temporary
Markdown report they can read on their own. Do not bury the answer in a long
report just because you can produce one, and do not withhold necessary detail
just to stay short.

## Useful moves

These are choices, not a checklist:

- Name the actor and action when an abstraction hides the real behavior.
- Make missing causal links and system boundaries explicit.
- Explain what a fact means and how strongly the evidence supports it.
- Use an example, sequence, or diagram when it reduces the reader's mental load.

## Preserve truth while simplifying

Clarity must not smooth away distinctions that matter. State uncertainty where
it affects the explanation. Do not turn a plausible mechanism into a diagnosis,
a proposed design into current behavior, or evidence from one stage into proof
about another. Prefer the simplest wording that keeps the real actors,
boundaries, sequence, and confidence of the claim intact.
