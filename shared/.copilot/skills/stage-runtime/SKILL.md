---
name: stage-runtime
description: Instructions for how to stage the Copilot Agent Runtime submodule
in the github/sweagentd project for e2e testing and verification.
---

Copilot Agent Runtime (github/copilot-agent-runtime) is a submodule in the
github/sweagentd project. When changes are made to the runtime, we need to stage
those changes in sweagentd, deploy that to staging, and test manually.

github/sweagentd has instructions about this in its readme. But the TLDR here is:
- create a new worktree for sweagentd (ws new name-of-worktree from within
~/Development/github/sweagentd).
- cd into the new worktree and update the runtime submodule to point to the
new runtime branches latest commit.
- open a draft PR for the sweagentd worktree, title it "STAGING ONLY: Testing
runtime change ....." or something similar.

That's it!
