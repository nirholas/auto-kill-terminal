#!/usr/bin/env bash
set -euo pipefail

# auto-kill-terminal devcontainer feature
# Adds terminal management rules to agent instruction files

AGENTS="${AGENTS:-all}"

TERMINAL_RULES='## Terminal Management

- **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
- **Always kill the terminal** after the command completes, whether it succeeds or fails — never leave terminals open
- Do not reuse foreground shell sessions — stale sessions block future terminal operations in Codespaces
- In GitHub Codespaces, agent-spawned terminals may be hidden — they still work. Do not assume a terminal is broken if you cannot see it
- If a terminal appears unresponsive, kill it and create a new one rather than retrying in the same terminal'

has_rules() {
  grep -q "Always kill the terminal" "$1" 2>/dev/null
}

append_rules() {
  local file="$1"
  if [[ -f "$file" ]] && has_rules "$file"; then
    echo "[auto-kill-terminal] Rules already present in $file"
    return
  fi
  mkdir -p "$(dirname "$file")"
  if [[ -f "$file" ]]; then
    echo "" >> "$file"
    echo "$TERMINAL_RULES" >> "$file"
  else
    echo "$TERMINAL_RULES" > "$file"
  fi
  echo "[auto-kill-terminal] Added rules to $file"
}

WORKSPACE="${_REMOTE_USER_HOME:-/workspaces}"

# Find the workspace directory
if [[ -d "$WORKSPACE" ]]; then
  # In Codespaces, find the first project directory
  for dir in "$WORKSPACE"/*/; do
    if [[ -d "$dir/.git" ]]; then
      WORKSPACE="$dir"
      break
    fi
  done
fi

cd "$WORKSPACE" 2>/dev/null || true

case "$AGENTS" in
  all)
    append_rules ".github/copilot-instructions.md"
    append_rules "CLAUDE.md"
    append_rules "GEMINI.md"
    append_rules "AGENTS.md"
    append_rules ".cursorrules"
    ;;
  copilot)
    append_rules ".github/copilot-instructions.md"
    ;;
  claude)
    append_rules "CLAUDE.md"
    ;;
  gemini)
    append_rules "GEMINI.md"
    ;;
  cursor)
    append_rules ".cursorrules"
    ;;
esac

echo "[auto-kill-terminal] Done! AI agents will now clean up terminals."

