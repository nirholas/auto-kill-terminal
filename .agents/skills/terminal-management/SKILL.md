# Terminal Management Skill

## Description

Teaches AI agents to properly manage VS Code terminal lifecycle — always use background terminals and kill them after commands complete. Prevents zombie terminal accumulation in GitHub Codespaces and VS Code.

## When to use

- Any time an agent needs to run a terminal command
- When working in GitHub Codespaces
- When working in any VS Code-based environment
- When agents spawn terminals via `run_in_terminal`

## Rules

1. **Always use background terminals** (`isBackground: true`) for every command so a terminal ID is returned
2. **Always kill the terminal** after the command completes, whether it succeeds or fails — never leave terminals open
3. Do not reuse foreground shell sessions — stale sessions block future terminal operations in Codespaces
4. In GitHub Codespaces, agent-spawned terminals may be hidden — they still work. Do not assume a terminal is broken if you cannot see it
5. If a terminal appears unresponsive, kill it and create a new one rather than retrying in the same terminal

## Correct Pattern

```
1. run_in_terminal(command, isBackground=true)  → terminal_id
2. await_terminal(terminal_id, timeout)          → output
3. kill_terminal(terminal_id)                    → cleanup
```

## Anti-Patterns

- Running commands with `isBackground: false` (no terminal ID returned, cannot clean up)
- Not calling `kill_terminal` after getting output
- Retrying in the same terminal when it appears unresponsive
- Assuming a hidden terminal is broken (common in Codespaces)

## Keywords

terminal, kill_terminal, await_terminal, run_in_terminal, isBackground, zombie terminal, ghost terminal, Codespaces, VS Code

