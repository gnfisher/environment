---
name: code-walkthrough
description: Explaining how existing code works to a human who is building a mental model. Use when the user asks you to read code and explain how it works, where to look, or why something breaks - especially open-ended "I think it works roughly like X, go check and tell me how it really works." Not for execution tasks, quick lookups, or when the user explicitly asks for a full dump.
---

# Explaining code to a human

The reader is building a mental model, not consuming a report. Optimise for
uptake - what lands in their head - not coverage. A correct explanation they
have to re-read three times has failed.

\*\*This is the skill: lead with the conclusion, in plain words, and make
everything after it support that one sentence.\*\* A human reads front-to-back and
builds the model as they go. A buried conclusion forces them to hold every fact
in suspense, reach the end, and re-read. Put the answer first and the rest is
evidence they can take or leave.

The failure this prevents is the dense dump: every fact at equal weight, the
logic compressed into arrows, five symbols a sentence, the actual point arriving
last. It is complete, correct, and unreadable. If you catch yourself writing it,
stop and find the one-sentence answer first.

## Moves

- **Open with the answer.** The first sentence is the thing they'd repeat to a
  coworker. If you can't say it in one plain sentence, you don't understand it
  yet - keep reading the code, not writing.
- **Keep the actor in the sentence.** Say who does what to what: "Launch rejects
  the path because it isn't on its allowlist", not "the path's absence in
  baseConfig results in rejection". Subjects performing actions, not conditions
  resolving into conditions.
- **Spell out the logic; don't punctuate it.** Write "which means", "so",
  "that's why" instead of `A -> B -> C`. A little repetition along the causal
  line is how it sticks.
- **Name the 2-3 symbols that carry the idea; link the rest.** Every identifier
  you keep costs the reader a lookup. Spend them on the ones that matter; point
  at `file:line` for the others.
- **Make "where to look" actionable, not just coordinates.** A pointer is a
  handoff: the reader is about to open that code to decide something or explain
  it to someone. So give each one enough tissue to land cold - what the symbol
  is and what it does there ("`baseConfig`, the map every workflow path is
  matched against"), not a bare `file:line`.

## When to widen, when to check

- **Start narrow, widen on request.** Give the broad shape first; go deep only
  after they steer or ask. Unless explicitly requested, exhaustive context is a second pass, not the first.
- **Only stop to confirm the angle when the ask is vague** ("how does auth work
  around here?"). When they've handed you a specific target ("it's in this area,
  check X"), skip the question and just give the broad shape.
- **Lead with a diagram for any flow across 3+ steps or components**
(mermaid/canvas in Desktop App, ASCII in terminal/CLI, \~4-7 nodes). Skip it for single-spot explanations. More than \~7 nodes means
  you're too low - zoom out.
- If they asked for "everything" or a full trace, give it. These defaults are
  for "help me understand", not for explicit dumps.

## Before you send, check

- Is the takeaway in the first sentence?
- Could the reader stop after the first short paragraph and still have the gist?
- Did any sentence carry its logic in arrows or commas instead of words?
- Did I name a symbol the reader doesn't need yet?
- Is this shaped like a story, or like a stack trace?

## Example - same facts, two shapes

Too dense (don't):
> Code Coverage is `IsThirdPartyApp()==false` -> `useCopilotAppForAuth==false` ->
> authenticates as its own integration and the path is `dynamic/<slug>/<slug>`;
> Launch exact-matches `baseConfig`, no entry -> `NotFound`; the monolith only
> forwards Launch's message on 422, so the 404 collapses into \`500 Failed to run
> dynamic workflow\`.

Lands better (do):
> **Short version:** a 404 deep inside Launch gets flattened into a meaningless
> 500 before it reaches the caller.
>
> Launch keeps an allowlist of valid workflow paths. This app's path isn't on
> it, so Launch rejects the call as NotFound. But the monolith only passes
> Launch's error through on a 422; anything else becomes a generic "500 Failed to
> run dynamic workflow". So the real cause, an unregistered path, is invisible by
> the time you see the 500.
>
> Where to look: the auth split is the `if useCopilotAppForAuth` branch in
> `actions.go:146` - that's what decides whether the path gets the third-party
> prefix or the bare slug. The allowlist itself is `baseConfig`, the map in
> Launch that every workflow path is matched against; an app works once its path
> has an entry there.
