# Examples

## Minimal Setup

The simplest way to use auto-kill-terminal. One file, five rules.

### GitHub Copilot Only

Create `.github/copilot-instructions.md`:

```markdown
## Terminal Management

- **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
- **Always kill the terminal** after the command completes, whether it succeeds or fails — never leave terminals open
- Do not reuse foreground shell sessions — stale sessions block future terminal operations in Codespaces
- In GitHub Codespaces, agent-spawned terminals may be hidden — they still work. Do not assume a terminal is broken if you cannot see it
- If a terminal appears unresponsive, kill it and create a new one rather than retrying in the same terminal
```

Done. That's it.

---

## Full Multi-Agent Setup

For a team that uses Copilot + Claude + Cursor:

```
your-project/
├── .github/
│   └── copilot-instructions.md    ← Copilot reads this
├── CLAUDE.md                       ← Claude reads this
├── .cursorrules                    ← Cursor reads this
└── AGENTS.md                       ← Shared rules (optional)
```

Each file contains the same 5 terminal management rules plus your project-specific instructions.

Use the installer to set this up in one command:

```bash
curl -fsSL https://raw.githubusercontent.com/nirholas/auto-kill-terminal/main/install.sh | bash -s -- --all
```

---

## Adding to an Existing CLAUDE.md

If you already have a `CLAUDE.md` with project-specific rules:

```markdown
# My Project

## Build Commands
- `npm run build` to build
- `npm test` to run tests

## Code Style
- Use TypeScript strict mode
- Prefer functional components

## Terminal Management
- **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
- **Always kill the terminal** after the command completes, whether it succeeds or fails — never leave terminals open
- Do not reuse foreground shell sessions — stale sessions block future terminal operations in Codespaces
- In GitHub Codespaces, agent-spawned terminals may be hidden — they still work. Do not assume a terminal is broken if you cannot see it
- If a terminal appears unresponsive, kill it and create a new one rather than retrying in the same terminal
```

Just add the Terminal Management section anywhere in the file. The agent will pick it up.

---

## Inline Task Prompt

When giving an agent a specific task and you want terminal hygiene baked in:

```
Fix the failing unit tests in src/auth/. Run each test file individually to identify failures.

**Terminal rules:** Always use `isBackground: true` for every terminal command, then kill the terminal after.
```

