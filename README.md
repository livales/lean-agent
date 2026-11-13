# lean-agent

A Claude Code plugin for teams: working rules that save tokens, and one shared workflow for every teammate and their AI agent.

It does three things:

1. **The agent reads less.** Short working rules load at the start of every session: read the index first, open only the file the task needs, never read the same thing twice.
2. **The agent changes less, and checks its work.** The smallest solution that fully solves the task, no drive-by refactors, then the repo's own checks.
3. **What the team learns stays in the repo.** Decisions, gotchas and new rules are written to the repo, so teammates and their agents don't repeat the same mistake.

## Install

Inside Claude Code, run these one at a time:

```
/plugin marketplace add livales/lean-agent
```

```
/plugin install lean-agent@livales
```

Then start a new session. To update later: `/plugin marketplace update livales`.

## What's inside

| Part | How to use it | What it does |
|---|---|---|
| Working rules ([RULES.md](RULES.md)) | Automatic at session start | About 500 tokens: context, change, verify, report, team |
| `team-memory` | Automatic, or `/lean-agent:team-memory` | Records decisions (`D<n>` in `docs/DECISIONS.md`), gotchas and rules in the right place in the repo |
| `lean-context` | `/lean-agent:lean-context` | Measures and trims AGENTS.md / CLAUDE.md, or creates them for a new repo |
| `ship` | `/lean-agent:ship` | Checks scope, runs the checks, updates docs, branches, then opens a PR that is ready to review |
| `handoff` | `/lean-agent:handoff`, `/lean-agent:handoff resume` | Writes the state of unfinished work to the PR, or continues from that note |

`ship`, `handoff` and `lean-context` run only when a person calls them, so their descriptions take no context.

## Suggested team flow

1. New repo, or a repo with a heavy CLAUDE.md: `/lean-agent:lean-context`.
2. Work as usual. The working rules are already active.
3. Stopping halfway: `/lean-agent:handoff`. The teammate who continues runs `/lean-agent:handoff resume` on the same branch.
4. Done: `/lean-agent:ship`.

## Measure context without the plugin

```bash
bash scripts/context-size.sh /path/to/repo
```

It prints the size of CLAUDE.md, AGENTS.md and every file they import, which is what each session pays for before any work starts.

## Other agents

Copy [RULES.md](RULES.md) into your project's `AGENTS.md`, or into your agent's own rules file. The skills in `skills/*/SKILL.md` are plain Markdown and work in any agent that supports skills.

## Changing this plugin

Read [AGENTS.md](AGENTS.md). Every line here is paid for by every user in every session, so add only what has proven necessary.

## Credits

Ideas borrowed from [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills), [ponytail](https://github.com/DietrichGebert/ponytail) and [caveman](https://github.com/JuliusBrussee/caveman).

## License

MIT
