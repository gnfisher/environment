---
name: rubber-duck
description: Invoke a powerful reasoning Agent to review your work, assist in
understanding complex logic, provide feedback on taste, and catch mistakes
before they reach the user.
---

Use this skill when a task would benefit from an independent critique pass or
when you need a rubber duck to help you reason through a problem.

How to invoke the rubber duck Agent:
- Use the local `rubber-duck` wrapper to send your query and relevant context to
  the Agent: `copilot --agent critic --model gpt-5.4 --effort high
"$YOUR_PROMPT_HERE"`.

Good times to use this skill:
1. After you have a plan, but before you implement a significant change.
2. After a draft implementation, to catch bugs, risky assumptions, and edge
cases.
3. When tests fail or behavior is surprising, to analyze likely causes and
recovery options.
4. Before finishing, to look for meaningful test gaps or design issues that
still matter.

Skip this workflow for small, mechanical, or low-risk edits where the extra pass
is not worth the overhead.

When you run the wrapper:
- Include the relevant files, plan, assumptions, or diff summary.
- Ask for substantive issues only.
- Treat its feedback as new evidence, not confirmation.

When reporting back to the user:
- Summarize only the important findings and how they changed your approach.
- Do not paste the full critique verbatim unless the user asks for it.
