---
name: tracer-bullet
description: Build fast learning loops with Pragmatic Programmer-style tracer bullets. Use when the user wants to avoid over-analysis, make progress through a thin end-to-end slice, validate an architecture, spike an unknown, or create a quick feedback loop in Go, TypeScript, VS Code, tests, debuggers, scripts, logs, or running systems.
---

# Tracer bullet development

Help the user learn by building a narrow, real path through the system instead
of trying to understand everything up front. Optimize for fast, concrete
feedback: a command, test, debugger session, local server, script, log line,
trace, metric, or visible behavior that can be rerun after each change.

The default move is not "explain the whole system." The default move is:

1. Name the learning goal.
2. Pick the thinnest production-shaped path that could teach it.
3. Build or modify only what that path needs.
4. Run the feedback loop.
5. Use the result to choose the next small step.

## Core idea

A tracer bullet is a narrow, end-to-end implementation that travels through the
real architecture. It is not a full feature and not a broad exploration pass. It
is a learning instrument: small enough to build quickly, real enough that the
feedback matters.

Prefer tracer bullets when the user is stuck analyzing, uncertain about design,
or facing a large system. Prefer throwaway spikes only when the unknown is
isolated and the code should not survive.

## Operating rules

- **Bias to action.** Read just enough code to choose the first slice. Do not map
  the whole system unless the first slice requires it.
- **State the slice plainly.** "We'll send one request through the handler,
  persistence boundary, and response path" is better than a broad design essay.
- **Keep it production-shaped.** Use real entry points, real types, real build
  paths, and real integration seams. Stub only the parts that are not under
  investigation.
- **Create a rerunnable loop.** Leave behind a command, test, script, debugger
  config, fixture, or documented manual step that can be repeated quickly.
- **Instrument the unknown.** Add focused logs, assertions, traces, counters, or
  breakpoints where they answer the current question. Remove temporary noise when
  it stops helping.
- **Learn from observed behavior.** After each run, say what changed in your
  understanding and what the next smallest useful step is.
- **Avoid fake completion.** A mock-only unit test is not a tracer bullet unless
  the learning goal is specifically about local logic.

## First response shape

When this skill is invoked, respond with a compact working frame:

```text
Learning goal: ...
First tracer bullet: ...
Feedback loop: ...
Stop when: ...
```

Then act. If code changes are appropriate, make them. If a plan is needed, keep
it short and immediately executable.

Only ask a question when the target behavior is genuinely ambiguous or the first
slice would create risky side effects. Otherwise choose a reasonable slice and
start.

## Slice patterns

Use these as defaults:

- **HTTP/API path:** one request, one handler/controller, one domain operation,
  one persistence or external-service seam, one observable response.
- **CLI path:** one command invocation, one parser path, one operation, one
  printed result or exit code.
- **Worker/event path:** one fixture event, one queue/dispatcher path, one
  handler, one side effect or recorded output.
- **UI path:** one interaction, one state transition, one API boundary, one
  visible result.
- **Library path:** one public API call, one realistic input, one asserted
  output, one failure case.
- **Migration/refactor path:** one representative caller moved end-to-end, with
  characterization coverage before and after.
- **Observability path:** one request or job carrying a correlation ID through
  logs, traces, metrics, or debug output.

## Feedback-loop menu

Pick the cheapest loop that gives real signal:

- A targeted test command with a narrow selector.
- A tiny executable script or fixture that drives the behavior.
- A local server plus one `curl` or browser interaction.
- A VS Code launch configuration and specific breakpoints.
- A watch mode for fast edit-run cycles.
- A log line or structured event proving the path was exercised.
- A trace ID, span, metric, or dashboard query for distributed behavior.
- A failing characterization test before changing legacy code.

Prefer existing project tools. Do not add new dependencies unless the existing
toolchain cannot produce a useful loop.

## Go defaults

- Use focused tests first: `go test ./path -run TestName -count=1`.
- For HTTP paths, prefer `httptest` when it still exercises real handlers and
  middleware.
- For CLIs, add or use a command-level test and a realistic argv fixture.
- For concurrency or data races, add a small reproducer, then run the targeted
  test with `-race` if practical.
- For debugger loops, use `dlv test` or a VS Code `launch.json` only when
  stepping through state will teach faster than print/assert cycles.
- Keep table tests small: one happy tracer case and one meaningful edge case is
  often enough for the first loop.

## TypeScript defaults

- Use the repo's existing runner: Vitest, Jest, Playwright, Cypress, Node test,
  or the package script already present.
- Prefer a single focused spec or scenario over broad suite runs.
- For services, drive one request through the real router or app factory.
- For UI work, use a component or browser test only if it exercises the state and
  integration boundary under investigation.
- For fast scripts, use the repo's existing `tsx`, `ts-node`, build output, or
  package script rather than inventing a new runner.
- For debugger loops, add or adjust a VS Code config only when the user benefits
  from stepping through the path repeatedly.

## Alternatives to tracer bullets

Use the right fast-learning tool:

- **Spike:** throwaway code to answer one risky question. Timebox it, label it
  as disposable, and convert only the learning into production code.
- **Walking skeleton:** the thinnest deployable system with build, run, test,
  and deployment/observability plumbing. Use when project shape is unknown.
- **Characterization test:** lock down current behavior before refactoring.
- **Probe instrumentation:** add temporary logs, metrics, spans, or assertions
  to reveal runtime truth.
- **Scenario harness:** a small script, fixture, or command that repeatedly
  drives a real user or system scenario.
- **Debug-first loop:** set breakpoints around the unknown and run one realistic
  scenario when dynamic state matters more than static reading.
- **Canary flag:** ship the narrow path behind a feature flag or limited route
  when production feedback is necessary.

## Guardrails

- Do not let "understanding" expand without a feedback artifact.
- Do not build horizontal layers with no end-to-end path.
- Do not over-mock the important boundary.
- Do not leave temporary debug noise in committed code.
- Do not claim success until the loop has actually run or the remaining manual
  step is explicit.

## Closing shape

End with what the loop taught and what changed. Keep it short:

```text
Tracer bullet in place: ...
Feedback loop: ...
Learned: ...
```
