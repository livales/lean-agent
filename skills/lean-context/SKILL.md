---
name: lean-context
description: Set up or trim a repo's always-loaded agent context (AGENTS.md, CLAUDE.md and their imports) so every session starts small and reads further docs only when needed.
argument-hint: "[audit|init]"
disable-model-invocation: true
---

# lean-context

Everything in AGENTS.md / CLAUDE.md and the files they import is paid for at the start of every session, by every teammate, whether the task needs it or not. Keep that part small and make the rest easy to find.

Mode: `$ARGUMENTS`. With no argument, use `audit` if the repo has an AGENTS.md or CLAUDE.md, otherwise `init`.

## Budget

Always-loaded total (the files plus everything they `@import`): aim for 4 KB or less, about 1,000 tokens. Above 8 KB, trimming is required.

Measure with:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/context-size.sh"
```

## What stays always-loaded

- One paragraph: what the project is, its stack, its status.
- Hard rules: only lines an agent would get wrong without being told.
- Commands: dev, build, check, test, deploy.
- A docs index: a table of `Need` → `Read`, so the agent opens one doc, not all of them.
- Gotchas that apply to almost every task.

## What moves out, into `docs/` with a row in the index

- File maps and folder tours. The agent can list files itself; keep only locations that are surprising.
- Step-by-step procedures (release, deploy, console setup).
- Rationale and history. These go to `docs/DECISIONS.md`.
- Rules for one area only (SEO, a single feature, a single service).

## What gets deleted

- Anything the code, the config or `package.json` already states.
- Generic advice ("write clean code", "add tests").
- Status notes that are no longer true.

## audit

1. Run the size script and read the always-loaded files.
2. Sort every block into stay, move or delete, using the lists above.
3. Show the user a table: block, verdict, destination, bytes saved. Wait for their yes, because these files are shared by the team.
4. Apply it. Moved text keeps its wording. Add an index row for each new doc, written as when to read it.
5. Run the size script again and report before and after.

## init

1. Read the README, `package.json` scripts and the top-level folders. Nothing else.
2. Write `AGENTS.md` from `${CLAUDE_PLUGIN_ROOT}/templates/AGENTS.md`, filling in only what you verified. Leave out a section that would be empty.
3. Write `CLAUDE.md` from `${CLAUDE_PLUGIN_ROOT}/templates/CLAUDE.md`, so Claude Code and other agents read the same rules.
4. Add `CLAUDE.local.md` to `.gitignore`.
5. Offer `${CLAUDE_PLUGIN_ROOT}/templates/settings.json` as `.claude/settings.json`: it stops agents from reading build output and lockfiles. Adjust the paths to the repo, and merge with an existing file instead of replacing it.
