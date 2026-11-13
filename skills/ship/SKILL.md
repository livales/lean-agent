---
name: ship
description: Check the current work and open a pull request with a body a teammate can review without asking questions.
disable-model-invocation: true
---

# ship

Take the current work to a reviewable pull request. Stop and report at the first step that fails.

1. **Scope.** Read `git status` and the diff. Only files the task needs. No secrets (`.env`, keys, service accounts), no `CLAUDE.local.md`, no build output. Unrelated changes stay out; tell the user about them.
2. **Checks.** Run the commands the repo names in AGENTS.md / CLAUDE.md / `package.json`: lint, typecheck, tests, build. If security rules changed (Firestore, Storage, database), run their tests too. A check that fails is fixed or reported, never skipped.
3. **Docs follow behaviour.** If behaviour, commands or status changed, update the README, the changelog or the doc that describes it. User-facing text exists in every language the repo supports. A decision made along the way is recorded with the `team-memory` skill.
4. **Branch and commit.** Never commit on the default branch; create a branch first. Follow the style of `git log -5` for the message.
5. **Pull request.** Push, then open the PR against the branch this repo's PRs normally target (check recent merged PRs; it is not always `main`). Use the body below.
6. **Stop there.** Don't merge and don't turn on auto-merge. Report the PR link and the state of CI.

## PR body

```markdown
## What
One or two sentences on what changes for the user or the system.

## Why
The problem or the request behind it.

## How to verify
1. Exact commands or clicks, and what should happen.

## Not done / risks
What was left out, what was not tested, what the reviewer should look at closely. "None" if none.
```

Keep it under 25 lines. No list of changed files; the diff shows that.
