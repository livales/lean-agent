---
name: team-memory
description: Record a decision, gotcha or rule in the repo so teammates and their agents don't rediscover it. Use when a choice is made between alternatives, a mistake cost a retry, the user corrects the approach, or they say "remember this" about project knowledge.
---

# team-memory

Personal memory helps one person on one machine. The repo is the only memory every teammate and every agent shares, so project knowledge goes there, in the smallest form that will still change behaviour.

## Where it goes

| What you learned | Where | Form |
|---|---|---|
| A decision: one option chosen over others | `docs/DECISIONS.md` | Next `D<n>` entry, see below |
| A gotcha: something that failed and will fail again | The doc for that area (`docs/…`, README section). Put it in AGENTS.md / CLAUDE.md only if it applies to almost every task | One line: what to do, then the symptom in brackets |
| A rule: an agent would get it wrong without being told | "Hard rules" in AGENTS.md / CLAUDE.md | One line, bold lead, cite the `D<n>` if there is one |
| Anything secret or private | `CLAUDE.local.md` (must be gitignored) | Never committed, never in a PR or commit message |
| A personal preference of one person | That person's own memory, not the repo | |

Use the repo's existing files and section names if they differ from these. Create `docs/DECISIONS.md` only if the repo has no decisions log.

## Decision format

```markdown
## D12 · 2026-11-13 · Static pages for SEO routes
**Decision:** SEO pages are built from the catalog at build time.
**Why:** Client-rendered pages were not indexed.
**Instead of:** Rendering on request in the Worker.
```

Number from the highest existing `D<n>`. Never renumber. To reverse a decision, add a new one and append `Superseded by D<n>.` to the old entry.

## Steps

1. Search the target file for an entry on the same subject. Update it instead of adding a second one.
2. Write the entry. Use absolute dates. State what to do; leave out the story of how it was found.
3. If the always-loaded file (AGENTS.md / CLAUDE.md) grew, check whether a line there can now move to a doc.
4. Commit it with the change it belongs to, or alone as `docs: …`.

## Don't record

- What the code, the types or the git history already say.
- Task status, plans, or a summary of what was done today.
- A gotcha that a code change can remove. Fix the code instead.
