# auto-kill-terminal Development Guidelines

## Terminal Management

- **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
- **Always kill the terminal** after the command completes, whether it succeeds or fails — never leave terminals open
- Do not reuse foreground shell sessions — stale sessions block future terminal operations in Codespaces
- In GitHub Codespaces, agent-spawned terminals may be hidden — they still work. Do not assume a terminal is broken if you cannot see it
- If a terminal appears unresponsive, kill it and create a new one rather than retrying in the same terminal

## Project Structure

```
auto-kill-terminal/
├── templates/           # Ready-to-use agent instruction files
├── docs/                # Extended documentation
├── .agents/skills/      # AI skill definitions
├── install.sh           # One-liner installer
├── llms.txt             # AI discovery (summary)
├── llms-full.txt        # AI discovery (full context)
└── README.md            # Main documentation
```

## Contributing

- Keep templates minimal — only terminal management rules
- Test with at least one AI agent before submitting
- Update the compatibility table in README.md when adding agents

