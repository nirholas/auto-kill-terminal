# Agent Instruction File Reference

A comprehensive list of where each AI coding agent reads its instructions from.

## File Locations

| Agent | File | Location | Format |
|---|---|---|---|
| GitHub Copilot | `copilot-instructions.md` | `.github/` | Markdown |
| Claude Code | `CLAUDE.md` | repo root | Markdown |
| Gemini | `GEMINI.md` | repo root | Markdown |
| Cursor | `.cursorrules` | repo root | Plain text / Markdown |
| Windsurf | `.windsurfrules` | repo root | Plain text / Markdown |
| Cline | `.clinerules` | repo root | Plain text / Markdown |
| Aider | `.aider.conf.yml` | repo root | YAML |
| Continue.dev | `.continuerc.json` | repo root | JSON |
| Multi-agent | `AGENTS.md` | repo root | Markdown |

## How Agents Read Instructions

### GitHub Copilot
- Reads `.github/copilot-instructions.md` automatically
- Also reads `AGENTS.md` if present
- Instructions are included in every agent mode conversation

### Claude Code
- Reads `CLAUDE.md` from the repo root automatically
- Instructions are prepended to the system prompt
- Also respects `AGENTS.md`

### Gemini
- Reads `GEMINI.md` from the repo root
- Used by Gemini in VS Code and other integrations

### Cursor
- Reads `.cursorrules` from the repo root
- Applied to all AI interactions within the project
- Also supports `.cursor/rules/` directory for multiple rule files

### Windsurf
- Reads `.windsurfrules` from the repo root
- Similar behavior to Cursor

### Cline
- Reads `.clinerules` from the repo root
- Applied to Cline's autonomous coding sessions

## Multi-Agent Strategy

If your team uses multiple agents, add the rules to ALL relevant files. The `install.sh --all` command handles this:

```bash
bash install.sh --all
```

This creates/updates: `.github/copilot-instructions.md`, `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, and `.cursorrules`.

