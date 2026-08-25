---
name: stage-runtime
description: "How to get a Copilot Agent Runtime change into github/sweagentd staging for e2e testing and verification. Covers the vendored agent-runtime bundle and the @github/copilot npm pin."
---

## Read this first

The `runtime/` git submodule in sweagentd is **dead**. Its release jobs were
removed. Bumping it ships no runtime code and only pollutes history. Do not
bump it to stage a change.

The shipping path is the vendored `agent-runtime/` bundle inside sweagentd.
See `docs/runtime-changes.md` and `docs/runtime-releases.md` in
github/sweagentd for the durable reference.

## Which kind of change is it?

**TypeScript runtime change** -> edit `agent-runtime/` in sweagentd directly.
That bundle is the shipping path, so the change is live as soon as it merges
and a vendored release builds.

**Rust runtime change** (anything under `src/runtime/` in
copilot-agent-runtime) -> it does not reach sweagentd by merging alone. The
compiled napi addon ships inside the `@github/copilot` npm package, and
sweagentd's build copies it out of `node_modules`. So it needs an npm pin bump:

1. Merge the copilot-agent-runtime PR.
2. Wait for the next `@github/copilot` prerelease. Publishes automatically
   every weekday at 9am ET, or dispatch `publish-cli.yml` manually.
3. Bump `@github/copilot` in `agent-runtime/package.json` in sweagentd.
   For a staging smoke test a pin-only bump is usually enough; a full
   re-vendor also re-copies the TS source.

There is no automation for step 3 - no Dependabot. Full re-vendors are manual
and land roughly weekly.

## Staging it

- `ws new name-of-worktree` from within `~/Development/github/sweagentd`.
- Make the change (edit `agent-runtime/`, or bump the npm pin).
- Open a PR titled "STAGING ONLY: Testing runtime change ...".
- Get it **approved, not merged**.
- In #sweagentd-ops: `.wcid sweagentd` to claim a free env, then
  `.deploy <PR url> to <env>`.
- Test against `github/padawan-testing-staging` (Linux) or
  `github/padawan-testing-staging-windows` (Windows).

The full click-testing checklist lives at
`.github/skills/test-runtime-pr-in-staging/VERIFY.md` in sweagentd.

## Caveat worth remembering

Jobs that fall back to the legacy path - self-hosted runners, non-standard
runners, some unsupported apps - are pinned to a frozen SHA that is no longer
built. They will never pick up a new runtime change. Only the vendored path
does.
