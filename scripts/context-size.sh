#!/usr/bin/env bash
# Prints the size of the always-loaded agent context of a repo:
# CLAUDE.md and AGENTS.md plus every file they pull in with an @import line.
# Usage: context-size.sh [repo-dir]
set -u
cd "${1:-.}" || exit 1

seen=""
total=0

add() {
  local f="${1#./}"
  [ -f "$f" ] || return 0
  case " $seen " in *" $f "*) return 0 ;; esac
  seen="$seen $f"
  local bytes
  bytes=$(wc -c < "$f" | tr -d ' ')
  total=$((total + bytes))
  printf '%7d B  ~%5d tok  %s\n' "$bytes" $((bytes / 4)) "$f"
  local dir line
  dir=$(dirname "$f")
  # An import is a line that is only "@path".
  while IFS= read -r line; do
    add "$dir/${line#@}"
  done < <(grep -E '^@[^ ]+$' "$f" || true)
}

add CLAUDE.md
add AGENTS.md

if [ "$total" -eq 0 ]; then
  echo "No CLAUDE.md or AGENTS.md here."
  exit 0
fi

printf '%7d B  ~%5d tok  TOTAL always loaded\n' "$total" $((total / 4))
if [ "$total" -gt 8192 ]; then
  echo "Over 8 KB: trim it (run /lean-agent:lean-context audit)."
elif [ "$total" -gt 4096 ]; then
  echo "Over the 4 KB target: worth a look."
else
  echo "Within the 4 KB target."
fi
