#!/usr/bin/env bash
set -euo pipefail

# auto-kill-terminal devcontainer feature (build stage)
#
# Feature install scripts run while the image is being built, before the
# workspace folder is mounted, so this stage cannot touch the project's agent
# instruction files. Instead it installs apply.sh and records the selected
# option; the feature's postCreateCommand runs apply.sh inside the workspace
# folder once the container exists.

AGENTS="${AGENTS:-all}"
SHARE_DIR="/usr/local/share/auto-kill-terminal"

mkdir -p "$SHARE_DIR"
printf '%s\n' "$AGENTS" > "$SHARE_DIR/agents"

cat > "$SHARE_DIR/apply.sh" <<'APPLY'
#!/usr/bin/env bash
set -euo pipefail

# Adds terminal management rules to the agent instruction files of whatever
# directory it is run from. The devcontainer postCreateCommand runs it inside
# the workspace folder.

SHARE_DIR="/usr/local/share/auto-kill-terminal"
AGENTS="${AGENTS:-}"
if [[ -z "$AGENTS" && -f "$SHARE_DIR/agents" ]]; then
  AGENTS="$(cat "$SHARE_DIR/agents")"
fi
AGENTS="${AGENTS:-all}"

TERMINAL_RULES='## Terminal Management

- **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
- **Always kill the terminal** after the command completes, whether it succeeds or fails. Never leave terminals open
- Do not reuse foreground shell sessions. Stale sessions block future terminal operations in Codespaces
- In GitHub Codespaces, agent-spawned terminals may be hidden. They still work, so do not assume a terminal is broken if you cannot see it
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
    printf '\n%s\n' "$TERMINAL_RULES" >> "$file"
  else
    printf '%s\n' "$TERMINAL_RULES" > "$file"
  fi
  echo "[auto-kill-terminal] Added rules to $file"
}

case "$AGENTS" in
  all)
    append_rules ".github/copilot-instructions.md"
    append_rules "CLAUDE.md"
    append_rules "GEMINI.md"
    append_rules "AGENTS.md"
    append_rules ".cursorrules"
    ;;
  copilot) append_rules ".github/copilot-instructions.md" ;;
  claude)  append_rules "CLAUDE.md" ;;
  gemini)  append_rules "GEMINI.md" ;;
  cursor)  append_rules ".cursorrules" ;;
  *)
    echo "[auto-kill-terminal] Unknown agents option: $AGENTS" >&2
    exit 1
    ;;
esac

echo "[auto-kill-terminal] Done. AI agents will now clean up terminals."
APPLY

chmod +x "$SHARE_DIR/apply.sh"
echo "[auto-kill-terminal] Installed $SHARE_DIR/apply.sh (agents=$AGENTS). It runs on container create."
