---
name: terminal-management
description: Run every shell command in a background terminal and kill it afterwards, so no zombie terminals pile up in VS Code or GitHub Codespaces. Use whenever you run terminal commands in a VS Code based environment.
---

# Terminal management

Agent-spawned terminals in GitHub Codespaces and VS Code are rarely cleaned up. Stale foreground sessions get reused, block new commands and may be hidden from the terminal panel. Follow these rules for every command.

## Rules

1. Always run commands as background terminals (`isBackground: true`) so a terminal ID is returned. Without an ID you cannot clean up.
2. Always kill the terminal when the command finishes, whether it succeeded or failed.
3. Do not reuse foreground shell sessions. A stale session blocks later terminal operations in Codespaces.
4. In Codespaces an agent-spawned terminal may be invisible in the UI. It still works, so do not conclude it is broken because you cannot see it.
5. If a terminal looks unresponsive, kill it and create a new one. Do not retry in the same terminal.

## Pattern

```
1. run_in_terminal(command, isBackground=true)  -> terminal_id
2. await_terminal(terminal_id, timeout)          -> output
3. kill_terminal(terminal_id)                    -> cleanup
```

The tool names above are the VS Code agent terminal tools the repo's rules refer to (`run_in_terminal`, `await_terminal`, `kill_terminal`). Use the equivalent tools of your host if they are named differently.

## Anti-patterns

- Running with `isBackground: false`, which returns no terminal ID.
- Skipping `kill_terminal` after reading the output.
- Retrying inside a terminal that appears stuck.
- Treating a hidden terminal as broken.

## Short forms for prompts

One line: `Terminal rules: Always use isBackground: true for every terminal command, then kill the terminal after.`

Three lines:

- Always use `isBackground: true` for every terminal command so a terminal ID is returned.
- Always kill the terminal after the command completes, whether it succeeds or fails.
- If a terminal appears unresponsive, kill it and create a new one.
