---
name: handoff
description: Write the state of unfinished work so a teammate or a new session can continue without re-exploring, or resume from such a note.
argument-hint: "[resume]"
disable-model-invocation: true
---

# handoff

Unfinished work costs the most tokens when the next person, or the next session, has to find out again what was already known. A handoff note carries that over.

Mode: `$ARGUMENTS`. With no argument, write a note. With `resume`, continue from one.

## Write

1. Commit the work in progress on its branch (never the default branch). No secrets, no `CLAUDE.local.md`.
2. Write the note below from what this session knows. Don't re-read files to write it.
3. Put it where the team will find it:
   - The branch has a PR: replace the `## Handoff` section of its body (`gh pr edit`), keep the rest.
   - No PR: ask the user whether to push and open a draft PR with the note as its body. If they say no, print the note so they can paste it.

```markdown
## Handoff · 2026-11-13
**Goal:** What done looks like, in one sentence.
**Done:** What works now and was verified, and how.
**Left:**
1. Next step, with the file path.
2. …
**Verify with:** Exact commands.
**Traps:** What was tried and failed, and why. What looks wrong but is intentional.
**Open questions:** What only the owner can decide.
```

25 lines at most. Paths and commands exact. Leave a heading out if it would be empty.

## Resume

1. Read the `## Handoff` section of the branch's PR (`gh pr view --json body`), or the note the user pasted.
2. Run `git log --oneline <base>..HEAD` and `git diff --stat <base>...HEAD`. Open only the files that step 1 of **Left** names.
3. Trust **Done** and **Traps**; don't redo or retry them. Put **Open questions** to the user before the step that depends on them.
4. Continue from **Left**, step 1.
