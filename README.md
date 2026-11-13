# lean-agent

A Claude Code plugin for teams: short working rules for how the agent reads, changes and checks code, and one shared workflow for every teammate and their AI agent.

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
| Working rules ([RULES.md](RULES.md)) | Automatic at session start | Context, change, verify, report, team. Adds about 1,200 input tokens per session (measured) |
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

The plugin is Claude Code only, but its two parts are plain Markdown and work elsewhere. Clone the repo once:

```bash
git clone https://github.com/livales/lean-agent.git ~/lean-agent
```

**1. Working rules.** Paste [RULES.md](RULES.md) into the rules file your agent reads. Putting it in the project's `AGENTS.md` shares it with the whole team.

| Agent | Rules file |
|---|---|
| Codex, Cursor, Hermes Agent, most others | `AGENTS.md` in the project |
| Gemini CLI | `GEMINI.md` in the project |

**2. Skills.** Copy the folders in `skills/` into your agent's skills folder:

| Agent | Command |
|---|---|
| Codex, Gemini CLI | `mkdir -p ~/.agents/skills && cp -r ~/lean-agent/skills/* ~/.agents/skills/` |
| Hermes Agent | `mkdir -p ~/.hermes/skills && cp -r ~/lean-agent/skills/* ~/.hermes/skills/` |
| Other agents | `npx skills add livales/lean-agent` ([skills CLI](https://github.com/vercel-labs/skills), choose your agent) |

Start a new session afterwards. To update, run `git -C ~/lean-agent pull` and copy again.

Things that differ outside Claude Code:
- Call a skill by name in your message, for example "run handoff resume". `/lean-agent:…` commands exist only in Claude Code.
- `ship`, `handoff` and `lean-context` are meant to run only when asked. Other agents may start them on their own, so leave them out if that happens.

**Using a model router such as 9router?** It only changes which model answers, not the agent. Follow the steps for the agent you run through it: for Claude Code, the [Install](#install) steps above.

## Changing this plugin

Read [AGENTS.md](AGENTS.md). Every line here is paid for by every user in every session, so add only what has proven necessary.

## Credits

Ideas borrowed from [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills), [ponytail](https://github.com/DietrichGebert/ponytail) and [caveman](https://github.com/JuliusBrussee/caveman).

## License

MIT
