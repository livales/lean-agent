# AGENTS.md

`lean-agent` is a Claude Code plugin: working rules loaded at session start (`RULES.md`, via `hooks/hooks.json`) and four skills in `skills/`.

## Hard rules
- **Every line costs tokens for every user in every session.** `RULES.md` stays under 2.5 KB. A skill description stays under 300 characters. Add a line only if agents get it wrong without it.
- **Nothing project-specific.** No product names, private repos or company rules. Those belong in each project's own AGENTS.md.
- **Skills with side effects** (`ship`, `handoff`, `lean-context`) keep `disable-model-invocation: true`: only a person starts them, and their descriptions stay out of context.
- After any change run `claude plugin validate .` and bump `version` in `.claude-plugin/plugin.json`, or installed copies won't update.
- Changes go through a branch and a pull request to `main`.
