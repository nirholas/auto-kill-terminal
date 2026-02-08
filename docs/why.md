# Why AI Agents Leave Zombie Terminals

## The Root Cause

VS Code's terminal API provides two modes for running commands:

### Foreground Mode (`isBackground: false`)

```
Agent → run_in_terminal(command, isBackground=false)
     ← output (no terminal ID returned)
```

The command runs in a shared foreground shell. The agent gets the output but **no terminal ID**. Without an ID, there's no way to call `kill_terminal`. The terminal lives forever.

Worse: the next time the agent runs a command, it may reuse this same shell session. If the session is in a bad state (wrong directory, environment variables changed, previous command still running), the new command fails silently or produces wrong output.

### Background Mode (`isBackground: true`)

```
Agent → run_in_terminal(command, isBackground=true)
     ← terminal ID (e.g., "abc-123")
Agent → await_terminal(id="abc-123", timeout=30000)
     ← output + exit code
Agent → kill_terminal(id="abc-123")
     ← terminal cleaned up
```

The command runs in a dedicated background terminal. The agent gets a unique terminal ID that it can use to:
1. Check output with `get_terminal_output`
2. Wait for completion with `await_terminal`
3. **Kill the terminal** with `kill_terminal`

## Why Codespaces Makes It Worse

In local VS Code, zombie terminals are annoying but visible — you can see them piling up in the terminal panel and manually close them.

In GitHub Codespaces, agent-spawned terminals are **hidden from the UI**. You don't see them in the terminal panel. They exist only at the system level, consuming shell processes, file descriptors, and memory.

The typical cascade:

1. Agent runs 10 commands → 10 zombie terminals
2. System shell pool starts filling up
3. New terminal spawns start taking longer
4. Agent detects the delay as an "unresponsive terminal"
5. Agent retries in the same terminal (making it worse)
6. Eventually: agent concludes "the terminal is broken" and stops using it entirely
7. You manually right-click → Kill Terminal on each one, or restart the Codespace

## Why Agents Don't Clean Up By Default

AI agents follow instructions. The VS Code terminal API documentation doesn't emphasize cleanup as a requirement. Most agent instruction files (CLAUDE.md, copilot-instructions.md, etc.) focus on what to build, not how to manage system resources.

Without explicit "kill the terminal" instructions, the agent has no reason to do it. It ran the command, got the output, and moved on. The terminal is an implementation detail it doesn't think about.

## The Fix Is Instructions, Not Code

This isn't a bug in VS Code or in any AI agent. It's a documentation gap. The terminal API works correctly — it just requires the caller to manage lifecycle. AI agents are the callers, and they need to be told to manage lifecycle.

Five bullet points in the right file is all it takes.

