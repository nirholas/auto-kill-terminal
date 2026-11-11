---
name: install-terminal-rules
description: Add the terminal management rules to a project's agent instruction files (CLAUDE.md, AGENTS.md, GEMINI.md, Copilot and Cursor rules) with the auto-kill-terminal install script. Use when a user wants every agent in their repo to clean up terminals.
---

# Install terminal rules into a project

The repo ships `install.sh`, a bash script that appends a "Terminal Management" section to the agent instruction files of a target project. It skips files that already contain the rules (it looks for the text "Always kill the terminal").

## Run it

Always preview first:

```
curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh -o install.sh
bash install.sh --dry-run
bash install.sh
```

With no target flags it detects existing agent files in the directory and appends the rules to them.

## Flags

- `--dry-run` show changes without writing files
- `--force` add the rules even if they already exist
- `--dir PATH` target directory (default: current directory)
- `--all` create all agent files (copilot, claude, gemini, agents, cursor)
- `--copilot` create or update `.github/copilot-instructions.md`
- `--claude` create or update `CLAUDE.md`
- `--gemini` create or update `GEMINI.md`
- `--cursor` create or update `.cursorrules`
- `--help` print usage

## Example

```
bash install.sh --dir ./my-project --claude --gemini --dry-run
bash install.sh --dir ./my-project --claude --gemini
```

Review the script before piping or running it, and show the user the dry-run output before writing. The repo also has ready-made files under `templates/` (`CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, `copilot-instructions.md`, `cursorrules`, `windsurfrules`, `clinerules`) for manual copying.
