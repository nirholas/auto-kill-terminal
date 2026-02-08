# Short-Form Terminal Management Snippets

Use these when you need a compact version for inline agent prompts or task descriptions.

## One-Liner

```markdown
**Terminal rules:** Always use `isBackground: true` for every terminal command, then kill the terminal after.
```

## Two-Liner

```markdown
**Terminal management**: Always use background terminals (`isBackground: true`), always kill terminals after commands complete. Do not reuse foreground shell sessions.
```

## Three-Liner

```markdown
**Terminal management:**
- Always use `isBackground: true` for every terminal command so a terminal ID is returned
- Always kill the terminal after the command completes, whether it succeeds or fails
- If a terminal appears unresponsive, kill it and create a new one
```

